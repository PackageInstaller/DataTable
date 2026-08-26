-- chunkname: @modules/logic/prototest/view/ProtoTestFileView.lua

module("modules.logic.prototest.view.ProtoTestFileView", package.seeall)

local ProtoTestFileView = class("ProtoTestFileView", BaseView)

function ProtoTestFileView:onInitView()
	self._btnSave = gohelper.findChildButtonWithAudio(self.viewGO, "Panel_storage/Panel_newFile/Btn_save")
	self._btnRefresh = gohelper.findChildButtonWithAudio(self.viewGO, "Panel_storage/Panel_oprator/Btn_refresh")
	self._btnOpenFolder = gohelper.findChildButtonWithAudio(self.viewGO, "Panel_storage/Panel_oprator/Btn_openFolder")
	self._inputFileName = gohelper.findChildTextMeshInputField(self.viewGO, "Panel_storage/Panel_newFile/Field_newcaseroot")
end

function ProtoTestFileView:addEvents()
	self._btnSave:AddClickListener(self._onClickBtnSave, self)
	self._btnRefresh:AddClickListener(self._onClickBtnRefresh, self)
	self._btnOpenFolder:AddClickListener(self._onClickBtnOpenFolder, self)
end

function ProtoTestFileView:removeEvents()
	self._btnSave:RemoveClickListener()
	self._btnRefresh:RemoveClickListener()
	self._btnOpenFolder:RemoveClickListener()
end

function ProtoTestFileView:onOpen()
	return
end

function ProtoTestFileView:_onClickBtnSave()
	local fileName = self._inputFileName:GetText()

	if ProtoTestMgr.instance:isRecording() then
		GameFacade.showToast(ToastEnum.ProtoModifyNotString)
	elseif string.nilorempty(fileName) then
		GameFacade.showToast(ToastEnum.ProtoModifyIsEmpty)
	elseif SLFramework.FileHelper.IsFileExists(ProtoFileHelper.getFullPathByFileName(fileName)) then
		GameFacade.showToast(ToastEnum.ProtoModifyIsFileExists)
	else
		local list = ProtoTestCaseModel.instance:getList()

		ProtoTestMgr.instance:saveToFile(fileName, list)
		ProtoTestFileModel.instance:refreshFileList()
	end
end

function ProtoTestFileView:_onClickBtnRefresh()
	ProtoTestFileModel.instance:refreshFileList()
end

function ProtoTestFileView:_onClickBtnOpenFolder()
	ZProj.OpenSelectFileWindow.OpenExplorer(ProtoFileHelper.DirPath)
end

return ProtoTestFileView
