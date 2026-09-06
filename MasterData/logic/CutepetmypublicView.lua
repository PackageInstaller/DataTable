-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutepetmypublicView.lua

module("logic.extensions.cutepet.view.CutepetmypublicView", package.seeall)

local CutepetmypublicView = class("CutepetmypublicView", ViewComponent)

CutepetmypublicView.Key_CD = "CutepetmypublicView.Key_CD"
CutepetmypublicView.CD_Time = 10

function CutepetmypublicView:ctor()
	CutepetmypublicView.super.ctor(self)
end

function CutepetmypublicView:unbindEvents()
	CutepetmypublicView.super.unbindEvents(self)
	self._btnChat:RemoveClickListener()
	self._btnInvite:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function CutepetmypublicView:bindEvents()
	CutepetmypublicView.super.bindEvents(self)
	self._btnChat:AddClickListener(self._onClickbtnChat, self)
	self._btnInvite:AddClickListener(self._onClickbtnInvite, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function CutepetmypublicView:buildUI()
	CutepetmypublicView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._btnChat = self:getBtn("btnChat")
	self._btnInvite = self:getBtn("btnInvite")
	self._btnClose = self:getBtn("btnClose")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtDesc = self:getTxt("txtDesc")
	self._emptyGo = self:getGo("empty")
	self._txtBtnChat = self:getTxt("btnChat/txt")
end

function CutepetmypublicView:onExit()
	CutepetmypublicView.super.onExit(self)
	self._scrollerList:dispose()
	removetimer(self._tickTime, self)
end

function CutepetmypublicView:onEnter()
	CutepetmypublicView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.CutePetTravelInfoRes, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.OnMsgAdd, self._onMsgAdd, self)

	self._targetTime = GameUtil.getUserData(CutepetmypublicView.Key_CD) or 0
	self._selectData = nil

	self:_updateUI()
	CutePetGardenAgent.instance:sendPM_CutePetTravelInfoReq()
end

function CutepetmypublicView:_updateUI()
	local info = CutePetModel.instance:getMyPetTravelInfo()

	if not info then
		return
	end

	local maxChatTime = CutePetConfig.instance:getCommonValue("CommunityBroadcastTimes", true)
	local pets = {}

	if info.pets then
		local maxTime = CutePetConfig.instance:getCommonValue("TravelCountEachCutePet", true)

		for i, v in ipairs(info.pets) do
			if v.travelCountNeeds > 0 then
				local petMo = CutePetModel.instance:getCutePeMo(v.cutePetId)

				if petMo then
					table.insert(pets, v)
				end
			end
		end
	end

	self._scrollerList:reloadData(pets)

	self._txtDesc.text = string.format("今日剩余：%s次", maxChatTime - info.broadcastTimes)

	goutil.setActive(self._emptyGo, #pets <= 0)
	self:_checkChatBtnState()
end

function CutepetmypublicView:_onClickbtnChat()
	local funcId = FriendConfig.instance:getCommonValue("CHANNEL_ASK_FOR_HELP_LIMIT_FUN_ID", true)

	if not FuncOpenModel.instance:getFuncIsOpen(funcId) then
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

		FuncOpenController.instance:showLockTips(cfg)

		return
	end

	if not self._selectData then
		FloatWordMgr.instance:show("选择要发布的萌宠")

		return
	end

	local info = CutePetModel.instance:getMyPetTravelInfo()

	if not info then
		return
	end

	local maxTime = CutePetConfig.instance:getCommonValue("CommunityBroadcastTimes", true)

	if maxTime - info.broadcastTimes <= 0 then
		FloatWordMgr.instance:show("今日发送次数不足")

		return
	end

	local nowTime = ServerTime.now()
	local leftTime = self._targetTime - nowTime

	if leftTime > 0 then
		FloatWordMgr.instance:show(string.format("冷却时间还有%ss", leftTime))

		return
	end

	self._targetTime = nowTime + CutepetmypublicView.CD_Time

	GameUtil.saveUserData(CutepetmypublicView.Key_CD, self._targetTime)

	local petMo = CutePetModel.instance:getCutePeMo(self._selectData.cutePetId)
	local raceCfg = CutePetConfig.instance:getCutePetById(petMo.raceId)
	local typeCfg = CutePetConfig.instance:getPetTypeCfg(raceCfg.type)
	local dataT = {
		tpId = 91,
		params = {
			userId = RoleModel.instance:getUserId(),
			cutePetRaceId = petMo.raceId,
			cutePetTypeNeeds = self._selectData.cutePetTypeNeeds,
			travelCountNeeds = self._selectData.travelCountNeeds,
			typeName = typeCfg.name
		}
	}
	local content = GameUtil.jsonToString(dataT)

	self._isSendNewMsg = true

	ChatController.instance:SendMsg(GameEnum.ChatChannel.Help, GameEnum.ChatType.CutePetTravel, content)
	self:_checkChatBtnState()
end

function CutepetmypublicView:_onClickbtnInvite()
	if self._selectData then
		local count = CutePetConfig.instance:getCommonValue("TravelCountEachCutePet", true)
		local allCutePetList = CutePetModel.instance:getAllCutePetsList()
		local isHit = false

		for i, v in ipairs(allCutePetList) do
			if count - v.travelCount > 0 and v.id == self._selectData.cutePetId then
				CutePetModel.instance:setTeamTravelSelectMo(v)
				UIStateManager.instance:push(ViewName.CutepettravelteaminvateView)

				isHit = true

				break
			end
		end

		if not isHit then
			UIStateManager.instance:push(ViewName.CutepettravelteamView)
		end
	else
		UIStateManager.instance:push(ViewName.CutepettravelteamView)
	end

	self:close()
end

function CutepetmypublicView:_onClickbtnClose()
	self:close()
end

function CutepetmypublicView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgType = goutil.findChildComponent(go, "container/cover/imgType", "UIImageSpriteChange")
	local txtName = goutil.findChildTextComponent(go, "container/cover/txtName")
	local txtTime = goutil.findChildTextComponent(go, "container/cover/txtTime")
	local con = goutil.findChild(go, "container/mask/con")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "container/btn")
	local goSelect = goutil.findChild(cell.gameObject, "container/select")
	local petMo = CutePetModel.instance:getCutePeMo(data.cutePetId)
	local raceCfg = CutePetConfig.instance:getCutePetById(petMo.raceId)

	imgType:SetState(raceCfg.type - 1)

	local typeCfg = CutePetConfig.instance:getPetTypeCfg(raceCfg.type)

	txtName.text = typeCfg.name
	txtTime.text = string.format("出游次数：%s次", data.travelCountNeeds)

	MaterialMgr.setIcon(con, MatType.CutePet, petMo.raceId)
	goutil.setActive(goSelect, self._selectData and self._selectData.cutePetId == data.cutePetId)
	btn:AddClickListener(function()
		self._selectData = data

		self._scrollerList:refresh()
	end)
end

function CutepetmypublicView:_clearCell(cell)
	local con = goutil.findChild(cell.gameObject, "container/mask/con")

	MaterialMgr.resetAll(con)
end

function CutepetmypublicView:_onMsgAdd(channel)
	if channel == GameEnum.ChatChannel.Help and self._isSendNewMsg then
		self._isSendNewMsg = false

		CutePetGardenAgent.instance:sendPM_CutePetTravelInfoReq()
	end
end

function CutepetmypublicView:_checkChatBtnState()
	local nowTime = ServerTime.now()
	local leftTime = self._targetTime - nowTime

	if leftTime > 0 then
		GameUtil.SetGray(self._btnChat.gameObject, true)
		settimer(1, self._tickTime, self, true)
		self:_tickTime()
	else
		GameUtil.SetGray(self._btnChat.gameObject, false)
		removetimer(self._tickTime, self)
	end
end

function CutepetmypublicView:_tickTime()
	local nowTime = ServerTime.now()
	local leftTime = self._targetTime - nowTime

	if leftTime > 0 then
		self._txtBtnChat.text = string.format("发布消息(%s)", leftTime)
	else
		self._txtBtnChat.text = "发布消息"

		removetimer(self._tickTime, self)
		GameUtil.SetGray(self._btnChat.gameObject, false)
	end
end

return CutepetmypublicView
