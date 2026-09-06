-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchQilin.lua

module("logic.extensions.guide.model.branch.GuideBranchQilin", package.seeall)

local GuideBranchQilin = class("GuideBranchQilin", GuideBranchBase)

GuideBranchQilin.QINLIN_FUN_ID = 35

function GuideBranchQilin:startGuide()
	GuideBranchQilin.super.startGuide(self)

	if FuncOpenModel.instance:getFuncIsOpenFinished(GuideBranchQilin.QINLIN_FUN_ID) then
		print(">>>>>>>>>>>>>> 判断【已经打开】")
		self:openView(GuideBranchQilin.QINLIN_FUN_ID)
	else
		print(">>>>>>>>>>>>>> 判断【没有打开】")
		GlobalDispatcher:addListener(GlobalNotify.FuncOpenFinished, self.openView, self)
	end

	return true
end

function GuideBranchQilin:shouldTrigger()
	if SceneMgr.instance.isGogingToEnterBattleScene then
		return
	end

	return GuideBranchQilin.super.shouldTrigger(self)
end

function GuideBranchQilin:openView(funcId)
	if funcId == GuideBranchQilin.QINLIN_FUN_ID then
		GlobalDispatcher:removeListener(GlobalNotify.FuncOpenFinished, self.openView, self)
		UIStateManager.instance:open(ViewName.guideQilin)
	end
end

return GuideBranchQilin
