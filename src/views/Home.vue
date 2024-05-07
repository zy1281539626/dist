<script setup>
import { ref, reactive } from 'vue'

const showDialog = ref(false)

const enumData = reactive({
  coinList: [],
  acList: [],
  useridList: []
})

const dataParams = reactive([
  {
    title: '',
    dataInfo: [
      {
        type: 'select',
        label: '使用者代号',
        value: '',
        letter: 'searchUserId',
        placeholder: '使用者代号',
        options: enumData.useridList,
        custom: true,
        showCustom: false
      },
      {
        type: 'select',
        label: '扣账户口',
        value: '',
        letter: 'searchDebitAc',
        placeholder: '扣账户口',
        options: enumData.acList,
        custom: true,
        showCustom: false
      },
      { type: 'transType', label: '交易类别', value: '', letter: 'searchCategory' },
      {
        type: 'select',
        label: '交易类型',
        value: '',
        letter: 'searchTransType',
        placeholder: '选择类型',
        options: [],
        hidden: true,
        custom: true,
        showCustom: false
      }
    ]
  },
  {
    title: '交易详情',
    dataInfo: [
      {
        type: 'text',
        label: '最低金额(',
        value: '',
        letter: 'searchFrAmt',
        placeholder: '0.00',
        align: 'left',
        showNumKeyboard: false
      },
      {
        type: 'text',
        label: '最高金额(',
        value: '',
        letter: 'searchToAmt',
        placeholder: '10,000,000,000,000.00',
        align: 'left',
        showNumKeyboard: false
      },
      {
        type: 'select',
        label: '货币',
        value: '',
        letter: 'searchCurrency',
        placeholder: '货币',
        options: enumData.coinList,
        custom: true,
        showCustom: false
      },
      {
        type: 'text',
        label: '最低金额(交易币种)',
        value: '',
        letter: 'searchFrTxnAmt',
        placeholder: '0.00',
        align: 'left',
        showNumKeyboard: false
      },
      {
        type: 'text',
        label: '最高金额(交易币种)',
        value: '',
        letter: 'searchToTxnAmt',
        placeholder: '10,000,000,000,000.00',
        align: 'left',
        showNumKeyboard: false
      },
      {
        type: 'transDate',
        label: '交易日期',
        value: '',
        letter: 'transDate',
        startLetter: 'searchFrTxdt',
        endLetter: 'searchToTxdt'
      },
      {
        type: 'text',
        label: '交易对手',
        value: '',
        letter: 'searchCounterParty',
        placeholder: '输入对手',
        maxlength: '25'
      },
      {
        type: 'text',
        label: '批次号/信息ID',
        value: '',
        letter: 'searchEnqPackageId',
        placeholder: '输入批次号/信息ID',
        maxlength: '17'
      }
    ]
  },
  {
    title: '参考编号',
    dataInfo: [
      {
        type: 'text',
        label: '档案参考号',
        value: '',
        letter: 'searchFileRef',
        placeholder: '输入档案参考号',
        maxlength: '11'
      },
      {
        type: 'text',
        label: 'iGTB参考号',
        value: '',
        letter: 'searchTransRefe',
        placeholder: '输入iGTB参考号',
        maxlength: '11'
      },
      {
        type: 'text',
        label: '客户参考号',
        value: '',
        letter: 'searchCustRef',
        placeholder: '输入客户参考号',
        maxlength: '16'
      },
      {
        type: 'text',
        label: '单据编号',
        value: '',
        letter: 'searchInstrNo',
        placeholder: '输入单据编号',
        maxlength: '11'
      },
      {
        type: 'text',
        label: '批量备考号',
        value: '',
        letter: 'searchUPLOADBatId',
        placeholder: '输入批量备考号',
        maxlength: '16'
      }
    ]
  }
])

let fields = reactive({
  data: dataParams
})
let formData = reactive({
  searchCurrency: { text: '', value: '' },
  searchTransType: { text: '', value: '' },
  searchDebitAc: { text: '', value: '' },
  searchUserId: { text: '', value: '' }
})
</script>

<template>
  <h1 @click="showDialog = true">点击打开弹窗</h1>
  <sail-cell title="标题" value="内容"></sail-cell>
  <sail-cell title="标题" value="内容"></sail-cell>
  <sail-cell title="标题" value="内容"></sail-cell>

  <sail-input></sail-input>

  <sail-popup
    v-model:show="showDialog"
    class="popup dialg-wrap search-dialog"
    :show-overlay="true"
    :close-on-click-overlay="false"
    :lock-scroll="true"
    :body-scroll="true"
    title="筛选"
    position="bottom"
    :closeable="true"
  >
    <div class="popup__content">
      <div class="content">
        <sail-form ref="formRef">
          <div v-for="(cardItem, cardIndex) in fields.data" :key="cardIndex" class="search-card">
            <div v-if="cardItem.title" class="search-title">{{ cardItem.title }}</div>
            <div v-for="(field, index) in cardItem.dataInfo" :key="index">
              <slot v-if="field?.customer" name="customer" :scoped="field"></slot>
              <div v-else-if="field.type === 'transType'">
                <div class="label-title type-title">{{ field.label }}</div>
                <div class="trans-content">
                  <sail-row :wrap="true" :gutter="8">
                    <sail-col v-for="(item, typeIndex) in transTypeList" :key="typeIndex">
                      <div :class="['trans-type-item', item.actived === 0 ? '' : 'actived', 'trans-label']">{{ item.label }}</div>
                    </sail-col>
                  </sail-row>
                </div>
              </div>
              <sail-input
                v-else-if="!field?.custom"
                v-model="formData[field.letter]"
                :type="field.type"
                style-type="filled"
                :name="field.letter"
                :label="field.label"
                :placeholder="field.placeholder"
                :input-align="field.align || 'left'"
                size="small"
                :maxlength="field.maxlength"
              >
              </sail-input>
            </div>
          </div>

          <div class="footer">
            <sail-button class="footer-btn" type="primary" style-type="outlined" block size="normal" @click="reset">重置</sail-button>
            <sail-button class="footer-btn" type="primary" style-type="filled" block size="normal" @click="confirmForm">确认</sail-button>
          </div>
        </sail-form>
      </div>
    </div>
  </sail-popup>
</template>

<style>
.search-dialog {
  max-height: 80vh;
}
.popup__content {
  padding: 16px;
}
</style>
