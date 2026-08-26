-- chunkname: @modules/logic/rouge/view/RougeTalentTreeBranchView.lua

module("modules.logic.rouge.view.RougeTalentTreeBranchView", package.seeall)

local RougeTalentTreeBranchView = class("RougeTalentTreeBranchView", BaseView)

function RougeTalentTreeBranchView:onInitView()
	self._tabIndex = self.viewContainer:getTabView()._curTabId
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._btnempty = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_empty")
	self._treenodeList = {}
	self._treeLightList = {}
	self._curSelectId = nil
	self._orderToDelayTime = {}
	self._flexibleTime = 0.3

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeTalentTreeBranchView:addEvents()
	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, self._refreshUI, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnClickTreeNode, self._SelectItem, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnCancelTreeNode, self.cancelSelectNode, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.onSwitchTab, self._onSwitchTab, self)
	self._btnempty:AddClickListener(self._btnemptyOnClick, self)
end

function RougeTalentTreeBranchView:removeEvents()
	self.removeEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeTalentTreeInfo, self._refreshUI, self)
	self.removeEventCb(self, RougeController.instance, RougeEvent.OnClickTreeNode, self._SelectItem, self)
	self.removeEventCb(self, RougeController.instance, RougeEvent.OnCancelTreeNode, self.cancelSelectNode, self)
	self.removeEventCb(self, RougeController.instance, RougeEvent.onSwitchTab, self._onSwitchTab, self)
	self._btnempty:RemoveClickListener()
end

function RougeTalentTreeBranchView:_editableInitView()
	return
end

function RougeTalentTreeBranchView:_btnemptyOnClick()
	RougeController.instance:dispatchEvent(RougeEvent.OnClickEmpty, self._tabIndex)
end

function RougeTalentTreeBranchView:_refreshUI(talentid)
	for _, node in ipairs(self._treenodeList) do
		if self._curSelectId == node:getID() then
			if talentid and talentid == node:getID() then
				node:refreshItem(false, talentid)
			else
				node:refreshItem(true)
			end
		else
			node:refreshItem(false)
		end
	end

	for _, light in ipairs(self._treeLightList) do
		self:_refreshLight(light)
	end

	if self._canplayAudio then
		AudioMgr.instance:trigger(AudioEnum.UI.LightTalentBranch)

		self._canplayAudio = false
	end
end

function RougeTalentTreeBranchView:_onSwitchTab(tabIndex)
	local isSelf = self._tabIndex == tabIndex

	if not isSelf then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	for _, light in ipairs(self._treeLightList) do
		if light.isPlayAnim then
			light.isPlayAnim = false

			gohelper.setActive(light.go, false)
		end

		self:_refreshLight(light)
	end

	if self._canplayAudio then
		AudioMgr.instance:trigger(AudioEnum.UI.LightTalentBranch)

		self._canplayAudio = false
	end
end

function RougeTalentTreeBranchView:_SelectItem(config)
	if not config then
		return
	end

	local talent = config.talent
	local id = config.id

	for _, node in ipairs(self._treenodeList) do
		if self._tabIndex == talent and node:getID() == id then
			if not self._curSelectId then
				node:refreshItem(true)

				self._curSelectId = id
			elseif self._currentSelectId ~= id then
				node:refreshItem(true)

				self._curSelectId = id
			end
		else
			node:refreshItem(false)
		end
	end
end

function RougeTalentTreeBranchView:cancelSelectNode(id)
	for _, node in ipairs(self._treenodeList) do
		if id == node:getID() then
			node:refreshItem(false)

			self._curSelectId = nil

			break
		end
	end
end

function RougeTalentTreeBranchView:onOpen()
	if not RougeTalentModel.instance:checkIsCurrentSelectView(self._tabIndex) then
		return
	end

	self._config = RougeTalentConfig.instance:getBranchConfigListByTalent(self._tabIndex)
	self._branchconfig = RougeTalentConfig.instance:getBranchLightConfigByTalent(self._tabIndex)

	if not self._branchconfig then
		logError("genuis_branch_light " .. self._tabIndex .. " not config!!!!")
	end

	self:_inititem()
	self:_initLight()
end

function RougeTalentTreeBranchView:_inititem()
	for index, co in ipairs(self._config) do
		local item = self._treenodeList[index]

		if not item then
			item = self:getUserDataTb_()

			local pos = string.gsub(co.pos, "#", "_")
			local trans = gohelper.findChild(self.viewGO, "item/#go_item" .. pos)
			local poolView = self.viewContainer:getPoolView()

			if poolView then
				item = poolView:getIcon(trans)
			end

			self._treenodeList[index] = item
		end

		item:initcomp(co, self._tabIndex)
		item:refreshItem()
	end
end

function RougeTalentTreeBranchView:_initLight()
	self._canplayAudio = false

	for index, co in ipairs(self._branchconfig) do
		local light = self._treeLightList[index]

		if not light then
			light = self:getUserDataTb_()

			local go = gohelper.findChild(self.viewGO, "light/" .. co.lightname)
			local animator = go:GetComponent(typeof(UnityEngine.Animator))

			if co.pos then
				local posList = {}

				if string.find(co.pos, "|") then
					local tempList = string.split(co.pos, "|")

					for _, value in ipairs(tempList) do
						local pos = string.splitToNumber(value, "#")

						table.insert(posList, pos)
					end
				else
					local pos = string.splitToNumber(co.pos, "#")

					table.insert(posList, pos)
				end

				if posList then
					light.posList = posList
				end
			end

			light.index = index
			light.name = co.lightname
			light.go = go

			gohelper.setActive(light.go, false)

			light.animator = animator
			light.talent = co.talent
			light.order = co.order
			light.allLight = self:_checkCanLight(light)
			light.isPlayAnim = false

			local clips = light.animator.runtimeAnimatorController.animationClips

			for i = 0, clips.Length - 1 do
				local name = clips[i].name

				if name:find("_light$") then
					light.animtime = clips[i].length
				end
			end
		end

		table.insert(self._treeLightList, light)
		self:_refreshLight(light)
	end

	if self._canplayAudio then
		AudioMgr.instance:trigger(AudioEnum.UI.LightTalentBranch)

		self._canplayAudio = false
	end
end

function RougeTalentTreeBranchView:_getDelayTime(light)
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

function RougeTalentTreeBranchView:_checkCanLight(light)
	local posList = light.posList

	for _, talentids in ipairs(posList) do
		local count = 0

		for _, talentid in ipairs(talentids) do
			if RougeTalentModel.instance:checkNodeLight(talentid) then
				count = count + 1
			end
		end

		if count == #talentids then
			return true
		end
	end

	return false
end

function RougeTalentTreeBranchView:onClose()
	self:recycleTreeNode()
end

function RougeTalentTreeBranchView:recycleTreeNode()
	if self._treenodeList then
		local poolView = self.viewContainer:getPoolView()

		for i, item in ipairs(self._treenodeList) do
			poolView:recycleIcon(self._treenodeList[i])

			self._treenodeList[i] = nil
		end
	end
end

function RougeTalentTreeBranchView:_refreshLight(light)
	local delayTime = self:_getDelayTime(light)
	local allLight = self:_checkCanLight(light)

	function self.playfunc(light)
		if not self.viewContainer or not self.viewContainer._isVisible then
			return
		end

		TaskDispatcher.cancelTask(self.playfunc, light)
		gohelper.setActive(light.go, true)
		light.animator:Update(0)
		light.animator:Play("light", 0, 0)

		light.isPlayAnim = true
	end

	if not allLight then
		gohelper.setActive(light.go, false)
	elseif not light.isPlayAnim then
		if light.allLight then
			TaskDispatcher.runDelay(self.playfunc, light, delayTime)

			self._canplayAudio = true
		else
			local delayTime = self:_checkBeforeBranchAllLightReturnDelayTime(light)

			TaskDispatcher.runDelay(self.playfunc, light, delayTime)

			light.allLight = true
			self._canplayAudio = true
		end
	end
end

function RougeTalentTreeBranchView:_checkBeforeBranchAllLightReturnDelayTime(light)
	local delayTime = 0
	local currentLigt = light

	while currentLigt.index > 1 and currentLigt.order > 1 do
		delayTime = delayTime + self:getBeforeLightAniTime(currentLigt)
		currentLigt = self._treeLightList[currentLigt.index - 1]
	end

	return delayTime
end

function RougeTalentTreeBranchView:getBeforeLightAniTime(light)
	local beforelight = self._treeLightList[light.index - 1]

	return (beforelight.allLight and not beforelight.isPlayAnim or nil) and light.animtime - self._flexibleTime
end

function RougeTalentTreeBranchView:onDestroyView()
	return
end

return RougeTalentTreeBranchView
