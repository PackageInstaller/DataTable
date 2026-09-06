-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchFunOpenBattle.lua

module("logic.extensions.guide.model.branch.GuideBranchFunOpenBattle", package.seeall)

local GuideBranchFunOpenBattle = class("GuideBranchFunOpenBattle", GuideBranchFunOpen)

function GuideBranchFunOpenBattle:checkFuncOpen(param)
	if checknumber(param.funcId) > 0 then
		self.FuncId = param.funcId

		if FuncOpenModel.instance:getFuncIsOpen(checknumber(param.funcId)) then
			print(">>>>>>>>>>>>>> GuideBranchFunOpen 判断【已经打开】", self.FuncId)
			self:openView(self.FuncId)
		else
			print(">>>>>>>>>>>>>> GuideBranchFunOpen判断【没有打开】", self.FuncId)
		end
	end
end

function GuideBranchFunOpenBattle:startGuide()
	if self._currGuide and not self._currGuide.isGuiding then
		if self._currGuide:checkFinish() then
			GuideController.instance:forceFinishBranch()
		else
			self._currGuide:startGuide()

			if self._currGuide:getGuideId() == 1 then
				GuideController.instance:finishGuide()
			end
		end
	end

	if self:isGuiding() then
		local guide = self:getGuide()
		local param = guide:getJsonParams()

		if param.pause == 1 then
			self.isPause = true

			BattleController.instance:setBattlePause(true)
			print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>       GuideBranchFunOpenBattle.super.startGuide(self)  pause       ")
		end
	end
end

function GuideBranchFunOpenBattle:shouldTrigger()
	if self._currGuide then
		local param = self._currGuide:getJsonParams()

		if checknumber(param.funcId) > 0 and not FuncOpenModel.instance:getFuncIsOpen(checknumber(param.funcId)) then
			return
		end

		if not self:checkPreBranch(param) then
			return
		end

		if not self:checkHasMaterial(param) then
			return
		end

		if not self:checkPassFb(param) then
			return
		end

		if not self:checkViewVar(param) then
			return
		end

		if not self:checkLegend(param) then
			return
		end

		if not self:checkKingway(param) then
			return
		end

		return self._currGuide:shouldTrigger()
	end
end

function GuideBranchFunOpenBattle:finishGuide()
	if self.isPause then
		self.isPause = false

		BattleController.instance:setBattlePause(false)
	end

	GuideBranchFunOpenBattle.super.finishGuide(self)
end

function GuideBranchFunOpenBattle:onEnterView(viewName)
	if self._currGuide and viewName == ViewName.Battle then
		return 1
	end

	return 0
end

return GuideBranchFunOpenBattle
