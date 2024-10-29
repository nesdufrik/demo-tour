<template>
  <div id="form" class="grid grid-cols-2 gap-2">
    <FloatLabel variant="in">
      <InputText
        id="identificador"
        v-model="form.identificador"
        autocomplete="off"
        disabled="true"
        fluid
      />
      <label for="identificador">Identificador:</label>
    </FloatLabel>
    <FloatLabel variant="in">
      <InputText id="sender" v-model="form.sender" autocomplete="off" fluid />
      <label for="sender">Enviado por:</label>
    </FloatLabel>
    <FloatLabel variant="in">
      <InputText id="status" v-model="form.status" autocomplete="off" fluid />
      <label for="status">Estado:</label>
    </FloatLabel>
    <FloatLabel variant="in">
      <InputText
        id="fechaCreacion"
        v-model="form.creacion"
        autocomplete="off"
        fluid
      />
      <label for="fechaCreacion">Recibido el:</label>
    </FloatLabel>
  </div>
  <Divider />
  <div id="table-details">
    <DataTable
      v-model:editingRows="editingRows"
      :value="form.actividades"
      editMode="row"
      dataKey="id"
      @row-edit-save="onRowEditSave"
    >
      <Column field="fecha" header="Fecha" style="width: 20%">
        <template #editor="{ data, field }">
          <InputText v-model="data[field]" fluid />
        </template>
      </Column>
      <Column field="descripcion" header="Descripcion" style="width: 20%">
        <template #editor="{ data, field }">
          <InputText v-model="data[field]" fluid />
        </template>
      </Column>
      <Column field="precio" header="Precio" style="width: 20%">
        <template #body="{ data, field }">
          {{ formatCurrency(data[field]) }}
        </template>
        <template #editor="{ data, field }">
          <InputNumber
            v-model="data[field]"
            mode="currency"
            currency="USD"
            locale="en-US"
            fluid
          />
        </template>
      </Column>
      <Column
        :rowEditor="true"
        style="width: 10%; min-width: 8rem"
        bodyStyle="text-align:center"
      ></Column>
    </DataTable>
  </div>
</template>
<script setup>
import { inject, onMounted, ref } from 'vue'

const dialogRef = inject('dialogRef')
const form = ref({})
const editingRows = ref([])

onMounted(() => {
  const params = dialogRef.value.data // {user: 'primetime'}
  form.value = params
  form.value.actividades = form.value.actividades.map((actividad, index) => ({
    ...actividad,
    id: crypto.randomUUID(),
    precio: 0,
  }))
  console.log(form.value)
})

const formatCurrency = value => {
  return new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
  }).format(value)
}

const onRowEditSave = event => {
  let { newData, index } = event

  form.value.actividades[index] = newData
}
</script>
