-- chunkname: @modules/logic/rouge/view/RougeTalentTreeTrunkView.lua

module("modules.logic.rouge.view.RougeTalentTreeTrunkView", package.seeall)

local RougeTalentTreeTrunkView = class("RougeTalentTreeTrunkView", BaseView)

function RougeTalentTreeTrunkView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simageallfininshedlight = gohelper.findChildSingleImage(self.viewGO, "#simage_allfininshed_light")
	self._btnoverview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_overview")
	self._gotoprighttips = gohelper.findChild(self.viewGO, "#go_topright/tips")
	self._txttoprighttips = gohelper.findChildText(self.viewGO, "#go_topright/tips/#txt_tips")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_topright/#txt_num")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_click")
	self._btnempty = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_empty")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._treenodeList = {}
	self._treeLightList = {}
	self._orderToDelayTime = {}
	self._orderToLightList = {}
	self._flexibleTime = 0.2

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeTalentTreeTrunkView:addEvents()
	self._btnoverview:AddClickListener(self._btnoverviewOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnempty:AddClickListener(self._btnclickEmpty, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, self._refreshUI, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.enterTalentView, self._onClickTalentTreeItem, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.reallyExitTalentView, self._onBackView, self)
end

function RougeTalentTreeTrunkView:removeEvents()
	self._btnoverview:RemoveClickListener()
	self._btnclick:RemoveClickListener()
	self._btnempty:RemoveClickListener()
	self.removeEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, self._refreshUI, self)
	self.removeEventCb(self, RougeController.instance, RougeEvent.enterTalentView, self._onClickTalentTreeItem, self)
	self.removeEventCb(self, RougeController.instance, RougeEvent.reallyExitTalentView, self._onBackView, self)
end

function RougeTalentTreeTrunkView:_editableInitView()
	self._season = RougeOutsideModel.instance:season()

	local branchId = 999

	self._config = RougeTalentConfig.instance:getRougeTalentDict(self._season)
	self._lightconfig = RougeTalentConfig.instance:getBranchLightConfigByTalent(branchId)
end

function RougeTalentTreeTrunkView:_refreshUI()
	for _, item in ipairs(self._treenodeList) do
		item.component:refreshItem()
	end

	for _, light in ipairs(self._treeLightList) do
		self:_refreshLight(light)
	end

	self._txtnum.text = RougeTalentModel.instance:getTalentPoint()

	local maxtalentpoint = RougeConfig.instance:getOutSideConstValueByID(RougeEnum.OutsideConst.SkillPointLimit)
	local getAllPoint = RougeTalentModel.instance:getHadAllTalentPoint()
	local param = {
		getAllPoint,
		maxtalentpoint
	}

	self._txttoprighttips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_talenttree_remaintalent"), param)
end

function RougeTalentTreeTrunkView:_btnclickOnClick()
	self._isopentips = not self._isopentips

	gohelper.setActive(self._gotoprighttips, self._isopentips)
end

function RougeTalentTreeTrunkView:_btnclickEmpty()
	if self._isopentips then
		self._isopentips = false

		gohelper.setActive(self._gotoprighttips, self._isopentips)
	end
end

function RougeTalentTreeTrunkView:onOpen()
	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(self._season)
	RougeOutsideRpc.instance:sendRougeMarkGeniusNewStageRequest(self._season)
	AudioMgr.instance:trigger(AudioEnum.UI.OpenTalentTrunkTreeView)

	self._txtnum.text = RougeTalentModel.instance:getTalentPoint()

	self:_initItem()
	self:_initLight()
end

function RougeTalentTreeTrunkView:_initItem()
	for index, value in ipairs(self._config) do
		local item = self._treenodeList[index]

		if not item then
			item = self:getUserDataTb_()

			local trans = gohelper.findChild(self.viewGO, "item/#go_item" .. index)
			local path = self.viewContainer:getSetting().otherRes.branchitem
			local go = self:getResInst(path, trans, "treenode" .. tostring(index))
			local treenode = MonoHelper.addNoUpdateLuaComOnceToGo(go, RougeTalentTreeItem)

			treenode:initcomp(go, value, index)

			item.go = go
			item.component = treenode
			self._treenodeList[index] = item
		end
	end
end

function RougeTalentTreeTrunkView:_initLight()
	for index, co in ipairs(self._lightconfig) do
		local light = self._treeLightList[index]

		if not light then
			light = self:getUserDataTb_()

			local go = gohelper.findChild(self.viewGO, "light/" .. co.lightname)

			if not go then
				logError("genuis_branch_light " .. self._tabIndex .. " not config!!!!")
			end

			local animator = go:GetComponent(typeof(UnityEngine.Animator))

			if co.pos then
				local posList = {}

				posList = string.splitToNumber(co.pos, "|")

				if posList then
					light.posList = posList
				end
			end

			light.name = co.lightname
			light.go = go
			light.index = index

			gohelper.setActive(light.go, false)

			light.animator = animator
			light.talent = co.talent
			light.order = co.order
			light.allLight = self:_checkCanLight(light)
			light.isPlayAnim = false

			if animator then
				local clips = light.animator.runtimeAnimatorController.animationClips

				for i = 0, clips.Length - 1 do
					local name = clips[i].name

					if name:find("_light$") then
						light.animtime = clips[i].length
						light.animCilp = clips[i]
					end
				end
			end
		end

		table.insert(self._treeLightList, light)

		self._orderToLightList[co.order] = self._orderToLightList[co.order] or {}

		table.insert(self._orderToLightList[co.order], light)
	end

	for _, light in ipairs(self._treeLightList) do
		self:_refreshLight(light)
	end
end

function RougeTalentTreeTrunkView:_checkCanLight(light)
	if light.order == 1 then
		return true
	end

	local posList = light.posList

	for _, talentid in ipairs(posList) do
		if not RougeTalentModel.instance:checkBigNodeLock(talentid) then
			return true
		end
	end

	return false
end

function RougeTalentTreeTrunkView:_getDelayTime(light)
	if not light.animator then
		return 0
	end

	local delayTime = 0
	local order = light.order

	if self._orderToDelayTime[order] then
		return self._orderToDelayTime[order]
	end

	local beforelight

	for i = 1, #self._treeLightList do
		if i > 1 and order > 1 then
			beforelight = self._treeLightList[i - 1]

			if self._orderToDelayTime[order - 1] then
				delayTime = self._orderToDelayTime[order - 1] + light.animtime - self._flexibleTime

				break
			else
				delayTime = light.animtime - self._flexibleTime

				break
			end
		end
	end

	if delayTime > 0 then
		self._orderToDelayTime[order] = delayTime
	end

	return delayTime
end

function RougeTalentTreeTrunkView:_btnoverviewOnClick()
	ViewMgr.instance:openView(ViewName.RougeTalentTreeOverview)
end

function RougeTalentTreeTrunkView:_onClickTalentTreeItem(tabIndex)
	if self._inAnim then
		return
	end

	self._inAnim = true

	self._animator:Update(0)
	self._animator:Play("click", 0, 0)

	local opentime = 0.5

	function self._openCallBack()
		TaskDispatcher.cancelTask(self._openCallBack, self)

		self._inAnim = false

		RougeTalentModel.instance:setCurrentSelectIndex(tabIndex)
		ViewMgr.instance:openView(ViewName.RougeTalentTreeView, tabIndex)
	end

	TaskDispatcher.runDelay(self._openCallBack, self, opentime)
end

function RougeTalentTreeTrunkView:_refreshLight(light)
	local allLight = self:_checkCanLight(light)
	local needUnlockList = RougeTalentModel.instance:getNextNeedUnlockTalent()
	local istarget = false

	if not allLight then
		for _, needunlockid in ipairs(needUnlockList) do
			for _, posid in ipairs(light.posList) do
				if needunlockid == posid then
					istarget = true

					break
				end
			end
		end

		if not istarget then
			gohelper.setActive(light.go, false)
		else
			local per = self:_getLightPer(light)

			if per > 0 then
				gohelper.setActive(light.go, true)
				light.animator:Update(0)
				light.animator:Play("light", 0, per * light.animtime)

				light.animator.speed = 0
			else
				gohelper.setActive(light.go, false)
			end
		end
	else
		gohelper.setActive(light.go, true)
		light.animator:Update(0)
		light.animator:Play("idle", 0, 0)
	end
end

function RougeTalentTreeTrunkView:_getLightPer(currentlight)
	local beforeOrderLightList = self._orderToLightList[currentlight.order - 1]
	local beforeBigestLight
	local bigestpos = 0
	local posIndex = 0

	for _, light in ipairs(beforeOrderLightList) do
		if #light.posList == 0 then
			beforeBigestLight = light

			break
		end

		for index, pos in ipairs(light.posList) do
			if bigestpos < pos then
				bigestpos = pos
				posIndex = index
				beforeBigestLight = light
			end
		end
	end

	local season = RougeOutsideModel.instance:season()

	if not beforeBigestLight.posList[posIndex] then
		local beforetalentid = 1
		local beforeconfig = RougeTalentConfig.instance:getConfigByTalent(season, beforetalentid)
		local currentconfig = RougeTalentConfig.instance:getConfigByTalent(season, currentlight.posList[1])
		local hasCost = RougeTalentModel.instance:getHadAllTalentPoint()

		if not beforeconfig.cost then
			local beforeCost = 0
			local num1 = hasCost - beforeCost
			local num2 = currentconfig.cost - beforeCost

			return num1 / num2
		end
	end
end

function RougeTalentTreeTrunkView:_checkBeforeBranchAllLightReturnDelayTime(light)
	local delayTime = 0
	local currentLigt = light

	while currentLigt.index > 2 and currentLigt.order > 2 do
		delayTime = delayTime + self:getBeforeLightAniTime(currentLigt)
		currentLigt = self._treeLightList[currentLigt.index - 1]
	end

	return delayTime
end

function RougeTalentTreeTrunkView:getBeforeLightAniTime(light)
	local beforelight = self._treeLightList[light.index - 1]

	return (beforelight.allLight and not beforelight.isPlayAnim or nil) and light.animtime - self._flexibleTime
end

function RougeTalentTreeTrunkView:_onBackView()
	self._animator:Update(0)
	self._animator:Play("back", 0, 0)
end

function RougeTalentTreeTrunkView:onClose()
	return
end

function RougeTalentTreeTrunkView:onDestroyView()
	if self._treenodeList and #self._treenodeList > 0 then
		for index, item in ipairs(self._treenodeList) do
			item.component:dispose()
		end

		self._treenodeList = nil
	end
end

return RougeTalentTreeTrunkView
