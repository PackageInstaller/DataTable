-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/FamilytporderView.lua

module("logic.extensions.familyteamplay.view.FamilytporderView", package.seeall)

local FamilytporderView = class("FamilytporderView", TableViewComponent)

function FamilytporderView:ctor()
	FamilytporderView.super.ctor(self)
end

function FamilytporderView:buildUI()
	FamilytporderView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnSortZdl = self:getBtn("btnSortZdl")
	self._sortTagGo = self:getGo("sortTag")
	self._sortTagChange = self._sortTagGo:GetComponent(ComponentType.UIImageSpriteChange)
end

function FamilytporderView:bindEvents()
	FamilytporderView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnSortZdl:AddClickListener(self._onClickbtnSortZdl, self)
end

function FamilytporderView:unbindEvents()
	FamilytporderView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSortZdl:RemoveClickListener()
end

function FamilytporderView:destroyUI()
	FamilytporderView.super.destroyUI(self)
end

function FamilytporderView:onEnter()
	FamilytporderView.super.onEnter(self)

	local param = self:getOpenParam()

	self._teamPlayType = param[1] or 1
	self._periodId = param[2] or 1
	self._curBossId = param[3] or 1
	self._sortUp = true
	self._ignoreUserId = {}

	GlobalDispatcher:addListener(GlobalNotify.UpdataTeamPlayMemberZdlInfo, self._updateView, self)
	FamilyteamplayController.instance:csSendViewMemberZdlInfoListReq()
	self:_updateView()
end

function FamilytporderView:onExit()
	FamilytporderView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataTeamPlayMemberZdlInfo, self._updateView, self)
end

function FamilytporderView:_onClickbtnSortZdl()
	self._sortUp = not self._sortUp

	self:_updateView()
end

function FamilytporderView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function FamilytporderView:_cellSize(view, index)
	return 100, 100
end

function FamilytporderView:_updateCell(view, cell, data)
	local btnOrder = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnOrder")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtPower = goutil.findChildTextComponent(cell.gameObject, "txtPower")
	local txtChallenge = goutil.findChildTextComponent(cell.gameObject, "txtChallenge")
	local headCon = goutil.findChild(cell.gameObject, "head")
	local imgNumComp = goutil.findChild(cell.gameObject, "imgNum"):GetComponent(ComponentType.UIImgNumeralText)
	local headInfo = data.headInfo

	HeadItemController.instance:setHeadCell(headCon, headInfo.headIconId, headInfo.headFrameId, headInfo.vipLv)

	txtPower.text = data.zdl
	txtName.text = data.headInfo.userName
	txtChallenge.text = string.format("%s/%s", data.hasChallengedTime, FamilyteamplayConfig.instance:getChallengeTimes(self._teamPlayType))

	imgNumComp:SetNum(cell.data)

	local isMe = data.headInfo.userId == RoleModel.instance:getUserId()

	goutil.setActive(btnOrder.gameObject, not isMe)

	if not isMe then
		btnOrder:AddClickListener(function()
			local text = string.format("是否确认给%s发送邀请消息", data.headInfo.userName)

			local function okFunc()
				local settingInfo = FamilyModel.instance:getMyFamilySettingInfo()

				if settingInfo then
					if not settingInfo.familyName then
						local familyName = "未知"
						local userName = RoleModel.instance:getUserName()
						local bossName = FamilyteamplayModel.instance:getCurrBossName()
						local receiveId = checknumber(data.headInfo.userId)
						local periodId = self._periodId
						local curBossId = self._curBossId
						local contentNew = {
							tpId = 20,
							params = {
								FTP = 1,
								FN = familyName,
								UN = userName,
								PID = periodId,
								BID = curBossId,
								BN = bossName,
								FID = FamilyModel.instance:getFamilyId()
							}
						}
						local json = require("cjson")
						local obj = json.encode(contentNew)

						self._ignoreUserId[receiveId] = true

						ChatController.instance:SendMsg(GameEnum.ChatChannel.Private, GameEnum.ChatType.System, obj, receiveId)
						self:_updateView()
					end
				end
			end

			TipsFacade.instance:openPopupWindow("提示", text, okFunc)
		end)
	end
end

function FamilytporderView:_updateView()
	local tempList = FamilyteamplayModel.instance:getMemberZdlInfoList() or {}

	self._curViewDatas = {}

	for i, data in ipairs(tempList) do
		if not self._ignoreUserId[checknumber(data.headInfo.userId)] then
			table.insert(self._curViewDatas, data)
		end
	end

	if self._sortUp then
		table.sort(self._curViewDatas, function(a, b)
			return a.zdl > b.zdl
		end)
	else
		table.sort(self._curViewDatas, function(a, b)
			return a.zdl < b.zdl
		end)
	end

	self._sortTagChange:SetState(self._sortUp and 0 or 1)
	self:reloadData()
end

return FamilytporderView
