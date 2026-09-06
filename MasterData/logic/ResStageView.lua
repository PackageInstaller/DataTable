-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/ResStageView.lua

module("logic.extensions.materialchallenge.view.ResStageView", package.seeall)

local ResStageView = class("ResStageView", ViewComponent)

function ResStageView:ctor()
	ResStageView.super.ctor(self)

	self._chapterId = 0
	self._stageId = 0
end

function ResStageView:buildUI()
	ResStageView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._bgBlur = self:getGo("blurBg"):GetComponent(typeof(UnityEngine.UI.RawImage))
	self._roleModel = self:getGo("roleModel")
	self._txtProgress = self:getGo("main/top/txtProgress"):GetComponent(goutil.Type_UIText)
	self._txtDesc = self:getGo("main/top/txtDesc"):GetComponent(goutil.Type_UIText)
	self._starContainer = self:getGo("main/top/stars")
	self._txtRecmdPower = self:getGo("main/top/fightpower/txtRecmdPower"):GetComponent(goutil.Type_UIText)
	self._btnAuto = self:getBtn("main/bottom/btnAuto")
	self._btnStart = self:getBtn("main/bottom/btnStart")
	self._txtStart = goutil.findChild(self._btnStart, "Text"):GetComponent(goutil.Type_UIText)
	self._petIcon = self:getGo("main/petIcon")
	self._tableview = self:getGo("main/bottom/rewardList"):GetComponent("UITableview")
	self._tableCell = self:getGo("main/bottom/rewardList/item")

	self._tableCell:SetActive(false)

	self._txtPower = self:getTxt("main/bottom/costPower/txtPower")
	self._freePower = self:getGo("main/bottom/freePower")
end

function ResStageView:bindEvents()
	ResStageView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnAuto:AddClickListener(self._onClickAuto, self)
end

function ResStageView:unbindEvents()
	ResStageView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnAuto:RemoveClickListener()
end

function ResStageView:onEnter()
	GlobalDispatcher:addListener(MopupModel.SweepSuccessed, self._setPower, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataTiliCount, self._setPower, self)

	local params = self:getOpenParam()

	if not params or not params[1] or not params[2] then
		return
	end

	self._chapterId = params[1]
	self._stageId = params[2]

	self:setBtnStartState(true)
	self._btnAuto.gameObject:SetActive(false)
	self:_setBlurBg()
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	self._curViewDatas = {}

	self:_refreshView()
	self:_loadIcon()
	self:_setPower()
end

function ResStageView:onExit()
	GlobalDispatcher:removeListener(MopupModel.SweepSuccessed, self._setPower, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataTiliCount, self._setPower, self)
	self:_removeBlurBg()
	self:_clearItems()
	self:_removeIcon()
end

function ResStageView:_clearItems()
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = {}

	self._tableview:UnRegisterAllCallbacks()
end

function ResStageView:_onClickClose()
	self:close()
end

function ResStageView:_onClickAuto()
	MopupModel.instance:cliclResPlotSweep(self._chapterId, self._stageId)
end

function ResStageView:_onClickStart()
	local costPower = self:_getCostPower()
	local curPower = SupplyModel.instance:getHaveTiliCount()

	if costPower > 0 and curPower < costPower then
		ViewMgr.instance:open(ViewName.RecoveryTili)

		return
	end

	self:_openCopyMissionView()
end

function ResStageView:_openCopyMissionView()
	self:_onClickClose()
	UIStateManager.instance:push(ViewName.MCMissionView, self._chapterId, self._stageId)
end

function ResStageView:_refreshView()
	local cfg = MaterialChallengeConfig.instance:getStageById(self._chapterId, self._stageId)

	if cfg then
		self._txtDesc.text = cfg.desc
		self._txtProgress.text = cfg.stageName

		local creepsMasterId = cfg.teamIds

		self:_updateRewardList(cfg)

		local cfgTeam = MaterialChallengeConfig.instance:getTeamCfg(creepsMasterId)

		self._txtRecmdPower.text = self:_getRecommendZdl(creepsMasterId, checknumber((cfgTeam or nil) and cfgTeam.heroSkillId))
		self._txtStart.text = "前往挑战"

		local isPass = MaterialChallengeModel.instance:isStagePassed(self._chapterId, self._stageId)

		self._btnAuto.gameObject:SetActive(isPass)
	end
end

function ResStageView:_updateRewardList(cfgStage)
	local aaa = string.split(nil, "#")

	if not self:_isStagePassed() and cfgStage and not string.nilorempty(cfgStage.firstPassPrize) then
		local items = string.split(cfgStage.firstPassPrize, "#")
		local length = #items

		for i = 1, length do
			local index = #self._curViewDatas + 1

			self._curViewDatas[index] = self._curViewDatas[index] or {}
			self._curViewDatas[index].rewardStr = items[i]
			self._curViewDatas[index].isProbability = false
			self._curViewDatas[index].isFirst = true
		end
	end

	if cfgStage and not string.nilorempty(cfgStage.randomRewardShow) then
		local str1 = MaterialMgr.changeItemStr(cfgStage.randomRewardShow)
		local rewardItems = string.split(str1, "#")

		for i = 1, #rewardItems do
			if not string.nilorempty(rewardItems[i]) then
				local index = #self._curViewDatas + 1

				self._curViewDatas[index] = self._curViewDatas[index] or {}
				self._curViewDatas[index].rewardStr = rewardItems[i]
				self._curViewDatas[index].isProbability = true
				self._curViewDatas[index].isFirst = false
			end
		end
	end

	if cfgStage and not string.nilorempty(cfgStage.rewardShow) then
		local arr = string.split(cfgStage.rewardShow, "#")
		local intervalList = string.split(cfgStage.intervalRewardShow, ",") or {}

		for k, v in ipairs(arr or {}) do
			local str = MaterialMgr.changeIfDrop(v)

			if not string.nilorempty(str) then
				local t = string.split(str, "#")

				for i, v2 in ipairs(t) do
					if not string.nilorempty(v2) then
						local index = #self._curViewDatas + 1

						self._curViewDatas[index] = self._curViewDatas[index] or {}
						self._curViewDatas[index].rewardStr = v2
						self._curViewDatas[index].isProbability = false
						self._curViewDatas[index].isFirst = false

						if intervalList[k] then
							self._curViewDatas[index].intervalDesc = intervalList[k]
						end
					end
				end
			end
		end
	end

	self._tableview:ReloadData()
end

function ResStageView:_isStagePassed()
	return MaterialChallengeModel.instance:isStagePassed(self._chapterId, self._stageId)
end

function ResStageView:_setBlurBg()
	self._bgBlur:Release()
	self._bgBlur:Capture()
	StaticBluredHook.instance:start(self.mainGO)
	self._bgBlur:AddCaptureFinishListener(self._onCaptureScreenFinish, self)
end

function ResStageView:_onCaptureScreenFinish()
	StaticBluredHook.instance:stop()
end

function ResStageView:_removeBlurBg()
	StaticBluredHook.instance:stop()
	self._bgBlur:Release()
end

function ResStageView:_getRecommendZdl(creepsMasterId, heroSkillId)
	local cCfgs = MaterialChallengeConfig.instance:getTeamPets(creepsMasterId)

	if not cCfgs then
		return 0
	end

	return (FightingPowerFormula.instance:getFightingPowerOfFmt(cCfgs, heroSkillId))
end

function ResStageView:_numInView()
	return #self._curViewDatas
end

function ResStageView:_cellSize(view, idx)
	if idx + 1 == #self._curViewDatas then
		return 110, 90
	end

	return 90, 90
end

function ResStageView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function ResStageView:_updateCell(view, cell, data)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	Framework.TransformUtil.SetLocalScale(parentGo.transform, 0.9, 0.9, 0.9)

	local imgFirstPass = goutil.findChild(cell.gameObject, "imgFirstPass")
	local imgPerfect = goutil.findChild(cell.gameObject, "imgProbability")
	local bg = goutil.findChild(cell, "bg")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")

	imgPerfect:SetActive(data.isProbability)
	imgFirstPass:SetActive(data.isFirst)

	local proxy = MaterialMgr.setCellByCfg(data.rewardStr, parentGo)

	if proxy then
		proxy.binder:setNum(0)
	end

	if not string.nilorempty(data.intervalDesc) then
		txtNum.text = data.intervalDesc

		bg:SetActive(true)
		txtNum.gameObject:SetActive(true)
	else
		bg:SetActive(false)
		txtNum.gameObject:SetActive(false)
	end
end

function ResStageView:_clearTableview(cell)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	MaterialMgr.resetAll(parentGo)
end

function ResStageView:setBtnStartState(isInteractable)
	self._btnStart.btn.interactable = isInteractable
end

function ResStageView:_loadIcon()
	local cfg = MaterialChallengeConfig.instance:getChapter(self._chapterId)

	if cfg then
		uGuiUtil.setSpriteToImage(self._petIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getCopyChapterBgUrl(cfg.stagePic))
	end
end

function ResStageView:_removeIcon()
	Framework.ImageBigBG.Get(self._petIcon):ClearImage()
end

function ResStageView:_getCostPower()
	local cfg = MaterialChallengeConfig.instance:getStageById(self._chapterId, self._stageId)

	return (cfg or nil) and (cfg.power or 0)
end

function ResStageView:_setPower()
	local maxFreeTimes = MaterialChallengeModel.instance:getFreeStrenghtMaxTimes(self._chapterId)
	local freeTimes = MaterialChallengeModel.instance:getFreeStrenghtTimes(self._chapterId) or 0

	self._freePower:SetActive(freeTimes < maxFreeTimes)

	local costPower = self:_getCostPower()

	self._txtPower.text = costPower

	local curPower = SupplyModel.instance:getHaveTiliCount()

	self:setBtnStartState(costPower <= curPower)
end

return ResStageView
