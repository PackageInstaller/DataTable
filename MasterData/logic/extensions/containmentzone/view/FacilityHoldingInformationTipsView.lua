-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/containmentzone/view/FacilityHoldingInformationTipsView.lua

module("logic.extensions.containmentzone.view.FacilityHoldingInformationTipsView", package.seeall)

local M = class("FacilityHoldingInformationTipsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._btnClose = self:getBtn("facility_holding_information_tips_1387858894")
	self._btnChange = self:getBtn("facility_holding_information_tips_-1076497076")
	self._btnUpGrade = self:getBtn("facility_holding_information_tips_-233288383")
	self._btnDetial = self:getBtn("facility_holding_information_tips_1391580386")
	self._imgIcon = self:getImage("facility_holding_information_tips_1108482289")
	self._txtHoldingRoom = self:getText("facility_holding_information_tips_276647870")
	self._txtName = self:getText("facility_holding_information_tips_782379802")
	self._txtPeriodBase = self:getText("facility_holding_information_tips_931315058")
	self._goPeriodBlue = self:getGo("facility_holding_information_tips_1403959633")
	self._txtPeriodBlue = self:getText("facility_holding_information_tips_580786367")
	self._goPeriodRed = self:getGo("facility_holding_information_tips_1273999816")
	self._txtPeriodRed = self:getText("facility_holding_information_tips_2025610046")
	self._txtMoodBase = self:getText("facility_holding_information_tips_306718688")
	self._goMoodBlue = self:getGo("facility_holding_information_tips_518649845")
	self._txtMoodBlue = self:getText("facility_holding_information_tips_1203707451")
	self._goScrollReward = self:getGo("facility_holding_information_tips_1115110357")
	self._goRewardItem = self:getGo("rewards_detail_item_2141037416")
	self._loopListHelper = LoopListHelper.New(self._goScrollReward)

	self._loopListHelper:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	self._guiAnimation = nil
	self._btnClose = nil
	self._btnChange = nil
	self._btnUpGrade = nil
	self._btnDetial = nil
	self._imgIcon = nil
	self._txtHoldingRoom = nil
	self._txtName = nil
	self._txtPeriodBase = nil
	self._goPeriodBlue = nil
	self._txtPeriodBlue = nil
	self._goPeriodRed = nil
	self._txtPeriodRed = nil
	self._txtMoodBase = nil
	self._goMoodBlue = nil
	self._txtMoodBlue = nil
	self._goScrollReward = nil
	self._goRewardItem = nil

	self._loopListHelper:Dispose()

	self._loopListHelper = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnChange:AddClickListener(self._onClickChange, self)
	self._btnUpGrade:AddClickListener(self._onClickUpGrade, self)
	self._btnDetial:AddClickListener(self._onClickDetial, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnChange:RemoveClickListener()
	self._btnUpGrade:RemoveClickListener()
	self._btnDetial:RemoveClickListener()
end

function M:onEnter()
	self._cellItem = {}

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Room)

	local info = self:getFirstParam()

	self.roomId = info and info.roomId
	self.protomerId = info and info.protomerId

	self:_updateShow(self.roomId, self.protomerId)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Room)

	self.roomId = nil
	self.protomerId = nil
	self._rewards = nil

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close")

	for key, value in pairs(self._cellItem or {}) do
		value:onExit()
	end

	self._cellItem = nil

	self._loopListHelper:ClearCells()
end

function M:_onClickClose()
	self:close()
end

function M:_onClickChange()
	if self.roomId then
		local theRoom = ContainmentModel.instance:getRoomInfoById(self.roomId)
		local oldProtomerId = theRoom:getProtomerId()

		if self.protomerId ~= oldProtomerId then
			local _protomerId = self.protomerId
			local protomerMo = ProtomerModel.instance:getProtomerInfo(_protomerId)
			local oldRoomId = protomerMo and protomerMo:getRoomId() or 1

			if oldRoomId > 0 then
				local protomerName = protomerMo and protomerMo:getProtomerName() or ""
				local showUpRoomId = oldRoomId > 1100 and oldRoomId - 1100 or oldRoomId
				local dialog = Dialog.showMessage(lang("tip_title"), string.format(lang("tip_already_room_replace"), protomerName, showUpRoomId))

				dialog:setConfirmListener(function()
					ContainmentZoneAgent.instance:sendChangeProtomerRequest(self.roomId, _protomerId)
					self:close()
				end, self)
			else
				ContainmentZoneAgent.instance:sendChangeProtomerRequest(self.roomId, _protomerId)
				self:close()
			end
		else
			self:close()
		end
	end
end

function M:_onClickUpGrade()
	if self.protomerId then
		ContainmentFacade.instance:openProtomerUpgradeView(self.protomerId)
	end
end

function M:_onClickDetial()
	if self.protomerId then
		ContainmentFacade.instance:openPrototypeInfoView(self.protomerId)
	end
end

function M:_updateShow(roomId, protomerId)
	local protomerMo = ProtomerModel.instance:getProtomerInfo(protomerId)
	local protomerInRoomId = protomerMo:getRoomId()
	local roomMo = ContainmentModel.instance:getRoomInfoById(roomId)

	self._txtHoldingRoom.text = roomMo:getRoomIDName()

	local cfgInfo = ContainmentConfig.instance:getProtomerInfoCoById(protomerId)

	self._txtName.text = cfgInfo.roomname

	self:setIcon(protomerId)

	if protomerInRoomId > 0 then
		local second_base = ContainmentUtil.getProtomerProductivitySecond(roomId, protomerId, true)
		local hour_base = second_base / 60 / 60

		self:setPeriodBase(string.format(lang("tip_xx_hour"), hour_base))

		local second_withHero = ContainmentUtil.getProtomerProductivitySecond(roomId, protomerId, false)
		local blueVal = math.floor((second_base - second_withHero) / second_base * 100)

		blueVal = blueVal * -1

		self:setPeriodBlue(false)
		self:setPeriodRed(blueVal ~= 0, string.format("%d%%", blueVal))
	else
		self:setPeriodBase(ContainmentUtil.getProtomerProductivitySecond(self.roomId, protomerId, true))
		self:setPeriodBlue(false)
		self:setPeriodRed(false)
	end

	local moodCostBase = ContainmentUtil.getDefaultMoodCost()

	self:setMoodBase(string.format("%0.1f", moodCostBase))

	if roomMo and roomMo:getHeroCount() > 0 then
		local realMoodCost = ContainmentUtil.getRoomHeroMoodBaseCost()
		local content = math.floor((moodCostBase - realMoodCost) / moodCostBase * 100)

		content = content * -1

		if content ~= 0 then
			self:setMoodBlue(true, content)
		else
			self:setMoodBlue(false)
		end
	else
		self:setMoodBlue(false)
	end

	self:_updateRewardShow(protomerId)
end

function M:setIcon(protomerId)
	ContainmentUtil.setProtomerDynIcon(self._imgIcon, protomerId, true)
end

function M:_updatePrototype(tablePrototypeLst)
	local count = #tablePrototypeLst

	while count > self._goPrototypeGroup.transform.childCount do
		goutil.cloneAndSetParent(self._goPrototypeItem, self._goPrototypeGroup.transform)
	end

	for i = 0, self._goPrototypeGroup.transform.childCount - 1 do
		local tmpGo = self._goPrototypeGroup.transform:GetChild(i).gameObject
		local show = i < #tablePrototypeLst

		if show then
			local prototypeIconUrl = tablePrototypeLst[i + 1].icon
			local prototypeName = tablePrototypeLst[i + 1].name
			local imgIcon = goutil.findChildImageComponent(tmpGo, "imgPrototype")
			local txtIcon = goutil.findChildTextComponent(tmpGo, "txtPrototype")

			IconLoader.setSprite(imgIcon, IconType.DynSpriteAtlas_Room, prototypeIconUrl)

			txtIcon.text = prototypeName
		end

		goutil.setActive(tmpGo, show)
	end
end

function M:_updateRewardShow(protomerId)
	local len = 0
	local cfg = ContainmentConfig.instance:getProtomerCoById(protomerId)
	local rewardCO = RewardConfig.instance:getRewardCfgByCode(cfg.goodsReward)

	self._rewards = {}

	table.insert(self._rewards, {
		echo = true,
		count = 0,
		itemId = cfg.echoReward
	})

	for i, v in ipairs(rewardCO.reward and rewardCO.reward or {}) do
		if not v.pool then
			table.insert(self._rewards, {
				echo = false,
				count = v.num,
				itemId = v.code
			})
		end
	end

	self._loopListHelper:SetListItemCount(#self._rewards, true)
	self._loopListHelper:RefreshAllShownItem()
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local data = self._rewards[curIndex]
	local itemData = ItemUtil.createItemData({
		itemId = data.itemId
	})

	itemData:setCount(data.count)

	local item = self._loopListHelper:NewListViewItem("backpack_item")
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, HoldRewardItemCell)

	shower:setCellData(itemData, curIndex)
	shower:setNumShow(false)
	shower:setHandler(self)

	local signTyp = data.echo and CommEnum.BackPackItemSignTyp.Probability or CommEnum.BackPackItemSignTyp.None

	shower:setSignShow(signTyp)
	shower:setIsShowTips(true)
	shower:setShowSelectedEffect(false)
	shower:setIsShowTipsPassEvent(false)

	self._cellItem[item.gameObject:GetInstanceID()] = shower

	return item
end

function M:onRewardItemSelect(cellRewardItem)
	local instanceId = cellRewardItem:getMainGo():GetInstanceID()

	for key, value in pairs(self._cellItem or {}) do
		if key ~= instanceId then
			value:setItemSelect(false)
		end
	end
end

function M:setPeriodBase(content)
	self._txtPeriodBase.text = content
end

function M:setPeriodBlue(show, content)
	if show then
		self._txtPeriodBlue.text = content
	end

	goutil.setActive(self._goPeriodBlue, show)
end

function M:setPeriodRed(show, content)
	if show then
		self._txtPeriodRed.text = content
	end

	goutil.setActive(self._goPeriodRed, show)
end

function M:setMoodBase(content)
	self._txtMoodBase.text = content
end

function M:setMoodBlue(show, content)
	if show then
		self._txtMoodBlue.text = content
	end

	goutil.setActive(self._goMoodBlue, show)
end

return M
