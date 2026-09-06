-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchFunOpen.lua

module("logic.extensions.guide.model.branch.GuideBranchFunOpen", package.seeall)

local GuideBranchFunOpen = class("GuideBranchFunOpen", GuideBranchBase)

function GuideBranchFunOpen:startGuide()
	if self._currGuide and not self._currGuide.isGuiding and self._currGuide:checkFinish() then
		GuideController.instance:forceFinishBranch()
	end

	self.FuncId = -1
	self.lastVarKey = nil

	local guide = self:getGuide()

	if guide then
		local param = guide:getJsonParams()

		if self:checkViewVar(param) then
			self._currGuide:startGuide()
			self:checkFuncOpen(param)
		end
	end
end

function GuideBranchFunOpen:checkFuncOpen(param)
	if checknumber(param.funcId) > 0 then
		self.FuncId = param.funcId

		if MainUIController.instance:getBtnHasOk(self.FuncId) then
			print(">>>>>>>>>>>>>> GuideBranchFunOpen 判断【已经打开】funcId:", self.FuncId)
			self:openView(self.FuncId)
		else
			print(">>>>>>>>>>>>>> GuideBranchFunOpen判断【没有打开】funcId:", self.FuncId)
			GlobalDispatcher:addListener(GlobalNotify.MainActBtnUpdate, self.openView, self)
		end
	end
end

function GuideBranchFunOpen:shouldTrigger()
	if not SceneMgr.instance.isGogingToEnterBattleScene or self._currGuide and self._currGuide:getJsonParams() and self._currGuide:getJsonParams().isGuideInBattle == 1 then
		-- block empty
	else
		return
	end

	if self._currGuide then
		local param = self._currGuide:getJsonParams()

		if not self:checkPreBranch(param) then
			return
		end

		if not self:checkHasMaterial(param) then
			return
		end

		if not self:checkHasMaterialList(param) then
			return
		end

		if not self:checkPassFb(param) then
			return
		end

		if not self:checkLegend(param) then
			return
		end

		if not self:checkKingway(param) then
			return
		end

		if not self:checkPetcollege(param) then
			return
		end
	end

	return (GuideBranchFunOpen.super.shouldTrigger(self))
end

function GuideBranchFunOpen:openView(funcId)
	if MainUIController.instance:getBtnHasOk(self.FuncId) then
		print(">>>>>>>>>>>>>> GuideBranchFunOpen 判断【已经打开22】", self.FuncId)
		GlobalDispatcher:removeListener(GlobalNotify.FuncOpenFinished, self.openView, self)
		GuideController.instance:finishGuide()
	else
		print(">>>>>>>>>>>>>> GuideBranchFunOpen 判断【没有打开22】", self.FuncId)
	end
end

function GuideBranchFunOpen:checkHasMaterialList(param)
	local list = param.materialList

	if list ~= nil then
		for i, matCfg in ipairs(list) do
			if self:checkOneMat(matCfg) == false then
				return false
			end
		end
	end

	return true
end

function GuideBranchFunOpen:checkHasMaterial(param)
	local matCfg = param.material

	if matCfg ~= nil then
		return self:checkOneMat(matCfg)
	end

	return true
end

function GuideBranchFunOpen:checkOneMat(matCfg)
	local info = string.split(matCfg, ":")
	local matType = checknumber(info[1])
	local cfgId = checknumber(info[2])
	local len = math.max(3, #info)
	local count = checknumber(info[len])
	local num = 0

	if matType == MatType.Pet and #info >= 3 then
		num = BagModel.instance:getRaceIdAndLvlCount(cfgId, checknumber(info[3]))

		print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> checkHasMaterial Pet ", matCfg, num, count)
	else
		num = MaterialFacade.instance:getMatNumber(matType, cfgId)

		print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> checkHasMaterial ", matCfg, num, count)

		if matType == MatType.StarGodPlus then
			num = 0

			local moList = StargodplusModel.instance:getFillerMoList()

			for i, mo in pairs(moList or {}) do
				if mo:getUsePetId() <= 0 and mo:getDefineId() == cfgId then
					num = num + 1
				end
			end
		end
	end

	if num > 0 and count <= num then
		return true
	else
		return false
	end
end

function GuideBranchFunOpen:checkKingway(param)
	if param ~= nil and param.kingway then
		local arr = param.kingway
		local battleId = checknumber(arr[1])
		local stageId = checknumber(arr[2])

		if KingWayModel.instance:GetKingWayProgress(battleId, stageId) then
			return true
		else
			return false
		end
	end

	return true
end

function GuideBranchFunOpen:checkPetcollege(param)
	if param ~= nil and param.college then
		local arr = param.college
		local challengeId = checknumber(arr[1])
		local stageId = checknumber(arr[2])

		if challengeId == BattleModel.instance.collegeChallengeId and (stageId == 0 or stageId == BattleModel.instance.collegeStageId) then
			return true
		else
			return false
		end
	end

	return true
end

function GuideBranchFunOpen:checkLegend(param)
	if param ~= nil and param.legend then
		local arr = param.legend
		local challengeId = arr[1]
		local stageId = arr[2]

		if LegendModel.instance:isStagePass(challengeId, stageId) then
			return true
		else
			return false
		end
	end

	return true
end

function GuideBranchFunOpen:checkPassFb(param)
	if param ~= nil and param.chapter then
		local arr = param.chapter
		local chapterId = arr[1]
		local stageId = arr[2]

		if PlotCopyModel.instance:isStagePassedAllCopy(chapterId, stageId) then
			return true
		else
			return false
		end
	end

	return true
end

function GuideBranchFunOpen:checkPreBranch(param)
	if param ~= nil and param.preBranch then
		if GuideController.instance:checkBranchIsFinish(param.preBranch) then
			return true
		else
			return false
		end
	end

	return true
end

function GuideBranchFunOpen:checkViewVar(param)
	if param ~= nil and param.checkVar then
		local key = param.checkVar

		if self.lastVarKey then
			GuideController.instance:clearVarCallBack(self.lastVarKey)
		end

		self.lastVarKey = key

		local val = GuideController.instance:getOrCheckVarAndDoOnce(key, GameUtil.handler(self.goContinue, self))

		return self:checkValIsMatch(key, val)
	end

	return true
end

function GuideBranchFunOpen:checkValIsMatch(key, val)
	local boo = false

	if val ~= nil then
		local param = self._currGuide:getJsonParams()
		local op = ""

		if param then
			op = param.checkVarOp or ""
		end

		boo = string.find(op, ">=") and checknumber(val) >= checknumber(string.split(op, ">=")[2]) or string.find(op, "<=") and checknumber(val) <= checknumber(string.split(op, "<=")[2]) or string.find(op, "==") and checknumber(val) == checknumber(string.split(op, "==")[2]) or string.find(op, "!=") and checknumber(val) ~= checknumber(string.split(op, "!=")[2]) or string.find(op, "~=") and checknumber(val) ~= checknumber(string.split(op, "~=")[2]) or string.find(op, ">") and checknumber(val) > checknumber(string.split(op, ">")[2]) or string.find(op, "<") and checknumber(val) < checknumber(string.split(op, "<")[2]) or string.find(op, "=") and checknumber(val) == checknumber(string.split(op, "=")[2]) or string.find(op, "is$") and val == string.split(op, "is$")[2] or true

		print(">>>>>>>>>> GuideBranchFunOpen:checkValIsMatch(key , val ,op)", key, val, op, boo)
	end

	if boo then
		GuideController.instance:clearVarCallBack(key)
	end

	return boo
end

function GuideBranchFunOpen:goContinue(key, val)
	print(">>>>>>>>>>> GuideBranchFunOpen：goContinue", key, val)

	if self:checkValIsMatch(key, val) then
		self._currGuide:startGuide()

		local param = self._currGuide:getJsonParams()

		self:checkFuncOpen(param)
	end
end

function GuideBranchFunOpen:finishGuide()
	if self.lastVarKey then
		GuideController.instance:clearVarCallBack(self.lastVarKey)
	end

	self.lastVarKey = nil

	GuideBranchFunOpen.super.finishGuide(self)
end

function GuideBranchFunOpen:onEnterView(viewName)
	if self._currGuide and viewName == ViewName.MainUI then
		return 1
	end

	return 0
end

return GuideBranchFunOpen
