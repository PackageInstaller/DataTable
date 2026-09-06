-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/view/PkListView.lua

module("logic.extensions.pk.view.PkListView", package.seeall)

local PkListView = class("PkListView", ViewComponent)

function PkListView:buildUI()
	PkListView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._recordBtn = self:getBtn("recordBtn")
	self._recordChange = goutil.findChildComponent(self.mainGO, "recordBtn", "UIChangeGroup")
	self._recordCell = self:getGo("recordCell")
	self._recordViewGo = self:getGo("recordView")
	self._recordView = ScrollerList.create(self._recordViewGo, self._recordCell, GameUtil.handler(self._updateRecordCell, self))
	self._goEmpty = self:getGo("goEmpty")
	self._goEmptyTxt = self:getTxt("goEmpty/text")
end

function PkListView:bindEvents()
	PkListView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._recordBtn:AddClickListener(self._onClickRecord, self)
end

function PkListView:unbindEvents()
	PkListView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._recordBtn:RemoveClickListener()
end

function PkListView:onEnter()
	PkListView.super.onEnter(self)
	self.addGEvent(self, TrainCampQieCuoAgent.TC_GetBattleRecordRes, self._onRecordRes, self)
	self.addGEvent(self, TrainCampQieCuoAgent.TC_GetBattleVideoRes, self._onBattleVideoRes, self)
	self:_onClickRecord()
end

function PkListView:onExit()
	PkListView.super.onExit(self)
end

function PkListView:_onClickRecord()
	self._recordChange:SetState(1)
	goutil.setActive(self._initeList, false)
	goutil.setActive(self._recordViewGo, true)
	TrainCampQieCuoAgent.instance:sendPM_TC_GetBattleRecordReq()
end

function PkListView:_updateRecordCell(view, cell, data, tag)
	local txtMode = goutil.findChildTextComponent(cell.gameObject, "bk/txtMode")

	HeadItemController.instance:setMyHeadCell(goutil.findChild(cell.gameObject, "bk/leftHead/imgHead"))

	local proxy = HeadItemController.instance:setHeadCellByInfo(goutil.findChild(cell.gameObject, "bk/rightHead/imgHead"), data.opHeadInfo)

	if proxy then
		proxy:setCallBack(function()
			FriendController.instance:showInfoView(data.opHeadInfo.userId, cell.gameObject)
		end)
	end

	goutil.findChildTextComponent(cell.gameObject, "bk/leftHead/txtName").text = RoleModel.instance:getUserName()
	goutil.findChildTextComponent(cell.gameObject, "bk/rightHead/txtName").text = data.opHeadInfo.userName

	local result = goutil.findChildComponent(cell.gameObject, "bk/imgResult", "UIImageSpriteChange")

	goutil.findChildTextComponent(cell.gameObject, "bk/txtLifeRemainLeft").text = data.myAlivePetSize
	goutil.findChildTextComponent(cell.gameObject, "bk/txtLifeRemainRight").text = data.opAlivePetSize

	local dateTable = GameUtil.time2date(tonumber(data.recordTime) / 1000)

	goutil.findChildTextComponent(cell.gameObject, "bk/txtTime").text = string.format("%d月%d日 %02d:%02d:%02d", dateTable.month, dateTable.day, dateTable.hour, dateTable.min, dateTable.sec)

	local imgChangeModebg = goutil.findChild(cell.gameObject, "bk/modebg"):GetComponent(ComponentType.UIImageSpriteChange)

	if data.myAlivePetSize > data.opAlivePetSize then
		result:SetState(0)
	elseif data.myAlivePetSize < data.opAlivePetSize then
		result:SetState(1)
	else
		result:SetState(2)
	end

	local btnDetail = Framework.ButtonAdapter.GetFrom(cell.gameObject, "bk/btnDetail")

	btnDetail:AddClickListener(function()
		self._cellData = data

		TrainCampQieCuoAgent.instance:sendPM_TC_GetBattleVideoReq(data.myAttackBattleId, data.opAttackBattleId)
	end)

	txtMode.text = data.mode == 0 and "<color=#13173a>自由切磋</color>" or "<color=#093901>自选切磋</color>"

	imgChangeModebg:SetState(data.mode == 0 and 0 or 1)
end

function PkListView:_onRecordRes(battleRecords)
	local rcdList = battleRecords

	rcdList = GameUtil.reverse(rcdList)

	self._recordView:reloadData(battleRecords)
	goutil.setActive(self._goEmpty, #battleRecords == 0)

	self._goEmptyTxt.text = "您还没有切磋记录哦~"
end

function PkListView:_onBattleVideoRes(msg)
	if self._cellData then
		local data = self._cellData
		local myForm, opForm = {}, {}

		for i, v in ipairs(data.myPetInfo) do
			myForm[v.posId + 1] = {
				raceId = v.faceId,
				isDead = v.isDie
			}
		end

		for index, value in ipairs(data.opPetInfo) do
			opForm[value.posId + 1] = {
				raceId = value.faceId,
				isDead = value.isDie
			}
		end

		for i = 1, 9 do
			if myForm[i] == nil then
				myForm[i] = {
					raceId = 0
				}
			end

			if opForm[i] == nil then
				opForm[i] = {
					raceId = 0
				}
			end
		end

		local myHeadInfo = RoleModel.instance:getHeadInfo()

		TraincampqiecuoModel.instance:setHeadInfo(myHeadInfo, data.opHeadInfo)
		TraincampqiecuoModel.instance:setPkResult(1, msg.myAttackBattleResult, msg.opAttackBattleResult, data.myAlivePetSize, data.opAlivePetSize, myForm, opForm, data.recordId)
		UIStateManager.instance:push(ViewName.PkBattlereSultView, true)
	end
end

return PkListView
