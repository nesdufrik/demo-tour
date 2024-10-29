<template>
  <div class="w-full flex justify-center">
    <div class="w-full md:w-3/4">
      <Menubar :model="items" class="mb-5" />
      <RouterView />
    </div>
  </div>
  <DynamicDialog />
</template>
<script setup>
import { ref } from 'vue'

const items = ref([
  { label: 'Inicio', icon: 'pi pi-home' },
  { label: 'Categorias', icon: 'pi pi-box' },
])
</script>
