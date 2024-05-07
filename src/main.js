import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import Sail from '@sail/ui'

import '@sail/ui/lib/style.css'

const app = createApp(App)

app.use(router)
app.use(Sail)
app.mount('#app')
