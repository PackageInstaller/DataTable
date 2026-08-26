-- chunkname: @modules/logic/prototest/view/ProtoTestCaseView.lua

module("modules.logic.prototest.view.ProtoTestCaseView", package.seeall)

local ProtoTestCaseView = class("ProtoTestCaseView", BaseView)

function ProtoTestCaseView:onInitView()
	self._btnRecord = gohelper.findChildButtonWithAudio(self.viewGO, "Panel_testcase/Panel_oprator/Btn_record")
	self._btnStop = gohelper.findChildButtonWithAudio(self.viewGO, "Panel_testcase/Panel_oprator/Btn_stop")
	self._btnClear = gohelper.findChildButtonWithAudio(self.viewGO, "Panel_testcase/Panel_oprator/Btn_clear")
	self._btnSendAll = gohelper.findChildButtonWithAudio(self.viewGO, "Panel_testcase/Panel_oprator/Btn_SendAll")
end

function ProtoTestCaseView:addEvents()
	self._btnRecord:AddClickListener(self._onClickBtnRecord, self)
	self._btnStop:AddClickListener(self._onClickBtnStop, self)
	self._btnClear:AddClickListener(self._onClickBtnClear, self)
	self._btnSendAll:AddClickListener(self._onClickBtnSendAll, self)
end

function ProtoTestCaseView:removeEvents()
	self._btnRecord:RemoveClickListener()
	self._btnStop:RemoveClickListener()
	self._btnClear:RemoveClickListener()
	self._btnSendAll:RemoveClickListener()
	TaskDispatcher.cancelTask(self._onFrameSendProto, self)
end

function ProtoTestCaseView:onOpen()
	self:_updateRecordBtn()
end

function ProtoTestCaseView:_updateRecordBtn()
	local isRecording = ProtoTestMgr.instance:isRecording()

	gohelper.setActive(self._btnRecord.gameObject, not isRecording)
	gohelper.setActive(self._btnStop.gameObject, isRecording)
end

function ProtoTestCaseView:_onClickBtnRecord()
	ProtoTestMgr.instance:startRecord()
	self:_updateRecordBtn()
end

function ProtoTestCaseView:_onClickBtnStop()
	ProtoTestMgr.instance:endRecord()
	self:_updateRecordBtn()
end

function ProtoTestCaseView:_onClickBtnClear()
	ProtoTestCaseModel.instance:clear()
end

function ProtoTestCaseView:_onClickBtnSendAll()
	local list = ProtoTestCaseModel.instance:getList()

	self._toSendProtoList = {}

	for _, one in ipairs(list) do
		local protobuf = one:buildProtoMsg()

		table.insert(self._toSendProtoList, protobuf)
	end

	TaskDispatcher.runRepeat(self._onFrameSendProto, self, 0.033)
end

function ProtoTestCaseView:_onFrameSendProto()
	if self._toSendProtoList and #self._toSendProtoList > 0 then
		local protobuf = table.remove(self._toSendProtoList, 1)

		LuaSocketMgr.instance:sendMsg(protobuf)
	end

	if not self._toSendProtoList or #self._toSendProtoList == 0 then
		self._toSendProtoList = nil

		TaskDispatcher.cancelTask(self._onFrameSendProto, self)
	end
end

return ProtoTestCaseView
