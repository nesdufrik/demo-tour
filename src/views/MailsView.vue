<template>
  <Card>
    <template #content>
      <DataTable :value="mails" tableStyle="min-width: 50rem">
        <Column field="identificador" header="Identificador"></Column>
        <Column field="status" header="Estado"></Column>
        <Column field="sender" header="Enviado por"></Column>
        <Column field="creacion" header="Fecha"></Column>
        <Column header="Acciones">
          <template #body="{ data }">
            <div class="flex gap-2">
              <Button
                icon="pi pi-eye"
                size="small"
                text
                rounded
                @click="showMail(data.identificador)"
              ></Button>
              <Button
                icon="pi pi-trash"
                size="small"
                text
                rounded
                severity="danger"
              ></Button>
            </div>
          </template>
        </Column>
      </DataTable>
    </template>
  </Card>
</template>
<script setup>
import { ref, defineAsyncComponent } from 'vue'
import { useDialog } from 'primevue/usedialog'

const url = 'https://n8n.friktek.com/webhook/getMails'
const mails = ref([])
const dialog = useDialog()
const detailComponent = defineAsyncComponent(
  () => import('@/components/DetailMailComponent.vue'),
)

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
    actividades: mail.actividades,
  }))
}

const showMail = id => {
  dialog.open(detailComponent, {
    props: {
      header: 'Detalle de correo',
      style: { width: '50vw' },
      breakpoints: {
        '960px': '75vw',
        '640px': '90vw',
      },
      modal: true,
    },
    data: mails.value.find(mail => mail.identificador === id),
  })
}

fetchMails()
</script>
