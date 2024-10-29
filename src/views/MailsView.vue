<template>
  <DataTable :value="mails" tableStyle="min-width: 50rem">
    <Column field="identificador" header="Identificador"></Column>
    <Column field="status" header="Estado"></Column>
    <Column field="sender" header="Enviado por"></Column>
    <Column field="creacion" header="Fecha"></Column>
    <Column header="Acciones">
      <template #body>
        <div class="flex gap-1">
          <Button icon="pi pi-eye" size="small" text></Button>
          <Button
            icon="pi pi-trash"
            size="small"
            text
            severity="danger"
          ></Button>
        </div>
      </template>
    </Column>
  </DataTable>
</template>
<script setup>
import { ref } from 'vue'
import { useDialog } from 'primevue/usedialog'

const url = 'https://n8n.friktek.com/webhook/getMails'
const mails = ref([])
const dialog = useDialog()

const fetchMails = async () => {
  const response = await fetch(url)
  const data = await response.json()

  mails.value = data.data.map(mail => ({
    identificador: mail.identificador,
    status: mail.status,
    sender: mail.sender,
    creacion: new Date(mail.creacion).toLocaleString('es-ES', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit',
    }),
  }))
}

fetchMails()
</script>
