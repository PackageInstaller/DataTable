-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoonewsView.lua

module("logic.extensions.zoo.view.ZoonewsView", package.seeall)

local ZoonewsView = class("ZoonewsView", ViewComponent)

function ZoonewsView:buildUI()
	ZoonewsView.super.buildUI(self)

	self._closeBtn = self:getBtn("bg/close")
	self._cell = self:getGo("bg/cell")
	self._view = ScrollerList.create(self:getGo("bg/view"), self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ZoonewsView:bindEvents()
	ZoonewsView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function ZoonewsView:unbindEvents()
	ZoonewsView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function ZoonewsView:onEnter()
	ZoonewsView.super.onEnter(self)

	self._canPairsAnimalList = {}
	self._animShowItems = {}
	self._waitingPairTime = ZooConfig.instance:getInviteMatchWaitingTime()

	self:_updateView()
	GlobalDispatcher:addListener(GlobalNotify.OnZooNotifyPairInvite, self._updateView, self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooHandleFriendInvitation, self._onZooHandleFriendInvitation, self)
end

function ZoonewsView:onExit()
	ZoonewsView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooHandleFriendInvitation, self._onZooHandleFriendInvitation, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooNotifyPairInvite, self._updateView, self)
	removetimer(self._tickWaitingInvitation, self)
end

function ZoonewsView:onExitFinished()
	ZoonewsView.super.onExitFinished(self)

	for k, value in pairs(self._animShowItems) do
		value.animalShow:clear()
		value.avatar:destroy()
	end

	self._animShowItems = nil
	self._refusedFriendId = nil
end

function ZoonewsView:_getCanPairAnimalList(raceId)
	if self._canPairsAnimalList[raceId] then
		return self._canPairsAnimalList[raceId]
	end

	local myZoo = ZooModel.instance:getMyZoo()

	self._canPairsAnimalList[raceId] = myZoo:getCanPairAnimalList(raceId)

	return self._canPairsAnimalList[raceId]
end

function ZoonewsView:_updateView()
	self._view:reloadData(table.values(ZooMatchModel.instance:getAllFriendInvitations() or {}))
	removetimer(self._tickWaitingInvitation, self)
	settimer(1, self._tickWaitingInvitation, self)
end

function ZoonewsView:_updateCell(view, cell, data)
	local now = ServerTime.now()

	goutil.setActive(cell.gameObject, true)
	self:_fillFriendInfo(cell, data)
	self:_fillPairPetInfo(cell, data)
	self:_fillWaitingStatus(now, cell, data, true)
end

function ZoonewsView:_fillWaitingStatus(now, cell, data, handlerEvt)
	local trueBtn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "true")
	local falseBtn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "false")
	local wait = goutil.findChild(cell.gameObject, "wait")
	local tip = goutil.findChildTextComponent(cell.gameObject, "tip")

	if self._refusedFriendId then
		if self._refusedFriendId or now > data.startTime + self._waitingPairTime then
			goutil.setActive(wait, false)
			goutil.setActive(tip.gameObject, true)
			goutil.setActive(trueBtn.gameObject, false)
			goutil.setActive(falseBtn.gameObject, false)

			tip.text = self._refusedFriendId and lang("petzoo_match_invite_hasrefused") or lang("petzoo_match_norespond")
		else
			goutil.setActive(wait, true)
			goutil.setActive(tip.gameObject, false)
			goutil.setActive(trueBtn.gameObject, true)
			goutil.setActive(falseBtn.gameObject, true)

			local canPairAnimalList = self:_getCanPairAnimalList(data.animalMo.raceId)
			local waitText = goutil.findChildTextComponent(wait, "time")
			local waitTime = data.startTime + self._waitingPairTime - now

			uGuiUtil.setGoGrayState(trueBtn.gameObject, #canPairAnimalList == 0)

			waitText.text = string.format(lang("petzoo_match_handle_timecount"), math.floor(waitTime))

			if handlerEvt then
				self:_registerEventListeners(trueBtn, falseBtn, data)
			end
		end
	end
end

function ZoonewsView:_registerEventListeners(trueBtn, falseBtn, data)
	trueBtn:RemoveClickListener()
	falseBtn:RemoveClickListener()
	trueBtn:AddClickListener(function()
		local canPairAnimalList = self:_getCanPairAnimalList(data.animalMo.raceId)

		if #canPairAnimalList > 0 then
			ZooMatchController.instance:sendPM_ZooHandleBuddyMatchRequestReq(data.matchId, data.friendId, true)
		else
			FloatWordMgr.instance:show(lang("petzoo_match_handle_nopets"))
		end
	end)
	falseBtn:AddClickListener(function()
		ZooMatchController.instance:sendPM_ZooHandleBuddyMatchRequestReq(data.matchId, data.friendId, false)
	end)
end

function ZoonewsView:_fillFriendInfo(cell, data)
	local friendMo = data.friendMo
	local head = goutil.findChild(cell.gameObject, "head")
	local name = goutil.findChildTextComponent(cell.gameObject, "name")

	HeadItemController.instance:setHeadCell(head, friendMo.headIconId, friendMo.headFrameId, friendMo.vipLv)

	name.text = data.friendMo:getValue("name")
end

function ZoonewsView:_fillPairPetInfo(cell, data)
	local animalName = goutil.findChildTextComponent(cell.gameObject, "animalName")
	local animalIcon = goutil.findChild(cell.gameObject, "animalIcon")

	animalName.text = data.animalMo.name

	local animalShow = self._animShowItems[cell]

	if animalShow == nil then
		local as, avatar = data.animalMo:showAnimalAvatar(animalIcon, 70, 80, 0.56, 0.45, AvatarUseType.Scene)

		animalShow = {
			animalShow = as,
			avatar = avatar
		}
		self._animShowItems[cell] = animalShow
	else
		local avatarMo = animalShow.avatar:getNewUseMo()

		avatarMo:setDataByAnimalMo(data.animalMo)
		animalShow.avatar:updateByMo(avatarMo)
	end
end

function ZoonewsView:_onZooHandleFriendInvitation(invitationMO, lastResult)
	if lastResult then
		self:close()
	else
		self._refusedFriendId = self._refusedFriendId or {}
		self._refusedFriendId[invitationMO.matchId] = true

		self._view:refresh()
	end
end

function ZoonewsView:_clearCell(cell)
	local trueBtn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "true")
	local falseBtn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "false")
	local head = goutil.findChild(cell.gameObject, "head")

	trueBtn:RemoveClickListener()
	falseBtn:RemoveClickListener()
	HeadItemController.instance:resetHeadCell(head)
end

function ZoonewsView:_tickWaitingInvitation()
	local view = self._view:getView()
	local cnt = view:GetVisibleCount() - 1
	local datas = self._view:getData()
	local now = ServerTime.now()

	for i = 0, cnt do
		local cell = view:GetCellByIndex(i)
		local index = cell.index
		local data = datas[index + 1]

		self:_fillWaitingStatus(now, cell, data)
	end
end

return ZoonewsView
