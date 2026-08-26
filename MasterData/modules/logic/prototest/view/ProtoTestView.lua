-- chunkname: @modules/logic/prototest/view/ProtoTestView.lua

module("modules.logic.prototest.view.ProtoTestView", package.seeall)

local ProtoTestView = class("ProtoTestView", BaseView)

function ProtoTestView:onInitView()
	self._testCaseGO = gohelper.findChild(self.viewGO, "Panel_testcase")
	self._storageGO = gohelper.findChild(self.viewGO, "Panel_storage")
	self._testCasePosX, _ = recthelper.getAnchorX(self._testCaseGO.transform)
	self._testCaseRepoBtn = gohelper.findChildButtonWithAudio(self.viewGO, "Panel_testcase/Panel_oprator/Btn_TestcaseRepo")
	self._closeStorageBtn = gohelper.findChildButtonWithAudio(self.viewGO, "Panel_storage/Panel_oprator/Btn_close")
end

function ProtoTestView:addEvents()
	self._testCaseRepoBtn:AddClickListener(self._onClickTestCaseRepoBtn, self)
	self._closeStorageBtn:AddClickListener(self._onClickCloseStorageBtn, self)
end

function ProtoTestView:removeEvents()
	self._testCaseRepoBtn:RemoveClickListener()
	self._closeStorageBtn:RemoveClickListener()
end

function ProtoTestView:onOpen()
	gohelper.setActive(self._testCaseGO, true)

	local isShowFiles = ProtoTestMgr.instance.isShowFiles

	gohelper.setActive(self._testCaseRepoBtn.gameObject, not isShowFiles)
	gohelper.setActive(self._storageGO, isShowFiles)
	recthelper.setAnchorX(self._testCaseGO.transform, (isShowFiles or nil) and (self._testCasePosX or 0))
end

function ProtoTestView:_onClickTestCaseRepoBtn()
	ProtoTestMgr.instance.isShowFiles = true

	ProtoTestFileModel.instance:refreshFileList()
	gohelper.setActive(self._testCaseRepoBtn.gameObject, false)
	ZProj.TweenHelper.DOAnchorPosX(self._testCaseGO.transform, self._testCasePosX, 0.1, function()
		gohelper.setActive(self._storageGO, true)
		ZProj.TweenHelper.DOFadeCanvasGroup(self._storageGO, 0, 1, 0.1)
	end)
end

function ProtoTestView:_onClickCloseStorageBtn()
	ProtoTestMgr.instance.isShowFiles = false

	ZProj.TweenHelper.DOFadeCanvasGroup(self._storageGO, 1, 0, 0.1, function()
		gohelper.setActive(self._storageGO, false)
		gohelper.setActive(self._testCaseRepoBtn.gameObject, true)
		ZProj.TweenHelper.DOAnchorPosX(self._testCaseGO.transform, 0, 0.1)
	end)
end

return ProtoTestView
