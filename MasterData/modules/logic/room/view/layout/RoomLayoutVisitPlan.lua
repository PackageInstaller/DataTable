-- chunkname: @modules/logic/room/view/layout/RoomLayoutVisitPlan.lua

module("modules.logic.room.view.layout.RoomLayoutVisitPlan", package.seeall)

local RoomLayoutVisitPlan = class("RoomLayoutVisitPlan", BaseView)

function RoomLayoutVisitPlan:onInitView()
	self._goplayinfo = gohelper.findChild(self.viewGO, "#go_playinfo")
	self._txtplanname = gohelper.findChildText(self.viewGO, "#go_playinfo/#txt_planname")
	self._btnplaninfo = gohelper.findChildButtonWithAudio(self.viewGO, "#go_playinfo/#txt_planname/#btn_planinfo")
	self._txtplayername = gohelper.findChildText(self.viewGO, "#go_playinfo/#txt_playername")
	self._txtplayerId = gohelper.findChildText(self.viewGO, "#go_playinfo/#txt_playerId")
	self._goplayericon = gohelper.findChild(self.viewGO, "#go_playinfo/#go_playericon")
	self._goshareinfo = gohelper.findChild(self.viewGO, "#go_shareinfo")
	self._txtsharecode = gohelper.findChildText(self.viewGO, "#go_shareinfo/go_sharecode/#txt_sharecode")
	self._btncopysharecode = gohelper.findChildButtonWithAudio(self.viewGO, "#go_shareinfo/go_sharecode/#btn_copysharecode")
	self._goplaninfo = gohelper.findChild(self.viewGO, "#go_shareinfo/#go_planinfo")
	self._txtplaninfodesc = gohelper.findChildText(self.viewGO, "#go_shareinfo/#go_planinfo/#txt_planinfodesc")
	self._gocomparing = gohelper.findChild(self.viewGO, "#go_shareinfo/#go_comparing")
	self._btncomparing = gohelper.findChildButtonWithAudio(self.viewGO, "#go_shareinfo/#go_comparing/txt_comparing/#btn_comparing")
	self._gocompare = gohelper.findChild(self.viewGO, "#go_shareinfo/#go_compare")
	self._btncompare = gohelper.findChildButtonWithAudio(self.viewGO, "#go_shareinfo/#go_compare/txt_compare/#btn_compare")
	self._btncopy = gohelper.findChildButtonWithAudio(self.viewGO, "layout/#btn_copy")
	self._gocopylock = gohelper.findChild(self.viewGO, "layout/#btn_copy/#go_copylock")
	self._gocopyunlock = gohelper.findChild(self.viewGO, "layout/#btn_copy/#go_copyunlock")
	self._btnshare = gohelper.findChildButtonWithAudio(self.viewGO, "layout/#btn_share")
	self._btnmoremask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_moremask")
	self._goinformexpand = gohelper.findChild(self.viewGO, "#go_informexpand")
	self._btninform = gohelper.findChildButtonWithAudio(self.viewGO, "#go_informexpand/#btn_inform")
	self._btnmore = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_more")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomLayoutVisitPlan:addEvents()
	self._btnplaninfo:AddClickListener(self._btnplaninfoOnClick, self)
	self._btncopysharecode:AddClickListener(self._btncopysharecodeOnClick, self)
	self._btncomparing:AddClickListener(self._btncomparingOnClick, self)
	self._btncompare:AddClickListener(self._btncompareOnClick, self)
	self._btncopy:AddClickListener(self._btncopyOnClick, self)
	self._btnshare:AddClickListener(self._btnshareOnClick, self)
	self._btnmoremask:AddClickListener(self._btnmoremaskOnClick, self)
	self._btninform:AddClickListener(self._btninformOnClick, self)
	self._btnmore:AddClickListener(self._btnmoreOnClick, self)
end

function RoomLayoutVisitPlan:removeEvents()
	self._btnplaninfo:RemoveClickListener()
	self._btncopysharecode:RemoveClickListener()
	self._btncomparing:RemoveClickListener()
	self._btncompare:RemoveClickListener()
	self._btncopy:RemoveClickListener()
	self._btnshare:RemoveClickListener()
	self._btnmoremask:RemoveClickListener()
	self._btninform:RemoveClickListener()
	self._btnmore:RemoveClickListener()
end

function RoomLayoutVisitPlan:_btncomparingOnClick()
	self:_compareRoom(false)
end

function RoomLayoutVisitPlan:_btnmoremaskOnClick()
	self:_showExpand(false)
end

function RoomLayoutVisitPlan:_btnmoreOnClick()
	self:_showExpand(self._isShowExpand ~= true)
end

function RoomLayoutVisitPlan:_btncompareOnClick()
	self:_compareRoom(true)
end

function RoomLayoutVisitPlan:_btninformOnClick()
	RoomInformController.instance:openShareTipView(self._playerMO, self._shareCode)
	self:_showExpand(false)
end

function RoomLayoutVisitPlan:_btnplaninfoOnClick()
	RoomLayoutController.instance:openCopyTips(self._planInfo)
end

function RoomLayoutVisitPlan:_btncopysharecodeOnClick()
	RoomLayoutController.instance:copyShareCodeTxt(self._shareCode)
end

function RoomLayoutVisitPlan:_btncopyOnClick()
	if not self._isShare then
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanNotCanCopy)

		return
	end

	if RoomLayoutController.instance:isOpen() then
		if RoomLayoutModel.instance:getCanUseShareCount() <= 0 then
			GameFacade.showToast(RoomEnum.Toast.LayoutPlanUseShareCodeNotNum)

			return
		end

		RoomLayoutController.instance:openCopyView(self._playerMO.name)
	else
		GameFacade.showToast(RoomEnum.Toast.LayoutPlanShareCodeNotOpen)
	end
end

function RoomLayoutVisitPlan:_btnshareOnClick()
	if self._playerMO:isMyFriend() then
		local viewParam = {
			preSendInfo = {
				recipientId = self._playerMO.userId,
				msgType = ChatEnum.MsgType.RoomSeekShare,
				content = luaLang("room_chat_seek_share_content")
			}
		}

		SocialModel.instance:setSelectFriend(self._playerMO.userId)
		SocialController.instance:openSocialView(viewParam)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomLayoutPlanApplyFriend, MsgBoxEnum.BoxType.Yes_No, self._sendAddFriend, nil, nil, self, nil, nil, self._playerMO.name)
	end
end

function RoomLayoutVisitPlan:_sendAddFriend()
	SocialController.instance:AddFriend(self._playerMO.userId)
end

function RoomLayoutVisitPlan:_editableInitView()
	self._playericon = IconMgr.instance:getCommonPlayerIcon(self._goplayericon)

	self._playericon:setEnableClick(false)
	self._playericon:setShowLevel(false)
	self:_showExpand(false)
end

function RoomLayoutVisitPlan:onUpdateParam()
	return
end

function RoomLayoutVisitPlan:onOpen()
	self:_refreshPlayerUI()
end

function RoomLayoutVisitPlan:onClose()
	return
end

function RoomLayoutVisitPlan:onDestroyView()
	return
end

function RoomLayoutVisitPlan:_refreshData()
	self._isShare = RoomController.instance:isVisitShareMode()
	self._curInfo = RoomModel.instance:getInfoByMode(RoomModel.instance:getGameMode())

	if not self._curInfo then
		return
	end

	self._planInfo = RoomLayoutHelper.createInfoByObInfo(self._curInfo)
	self._shareCode = nil
	self._planName = nil
	self._isCompareInfo = false
	self._playerMO = self._playerMO or SocialPlayerMO.New()

	if self._isShare then
		local shareInfo = self._curInfo
		local info = self:_createPlayerInfo(shareInfo.shareUserId, shareInfo.nickName, shareInfo.levle, shareInfo.portrait, shareInfo.time)

		self._playerMO:init(info)

		self._shareCode = shareInfo.shareCode
		self._planName = shareInfo.roomPlanName

		local visitParam = RoomModel.instance:getVisitParam()

		if RoomLayoutHelper.checkVisitParamCoppare(visitParam) then
			self._isCompareInfo = true
		end

		if string.nilorempty(self._planName) then
			self._planName = formatLuaLang("room_layoutplan_default_name", "")
		end
	else
		local info = SocialModel.instance:getPlayerMO(self._curInfo.targetUid) or self:_createPlayerInfo(self._curInfo.targetUid)

		self._playerMO:init(info)
		self:_checkPlayerInfo(self._playerMO)

		self._planName = formatLuaLang("room_layoutplan_look_details", self._playerMO.name or "")
	end
end

function RoomLayoutVisitPlan:_createPlayerInfo(userId, name, level, portrait, time)
	local info = {
		userId = userId or 0,
		name = name,
		portrait = portrait or 0,
		level = level or 1,
		time = time or 0
	}

	self:_checkPlayerInfo(info)

	return info
end

function RoomLayoutVisitPlan:_checkPlayerInfo(info)
	if string.nilorempty(info.name) then
		info.name = string.format("#%s", info.userId)
	end
end

function RoomLayoutVisitPlan:_refreshPlayerUI()
	self:_refreshData()

	if not self._curInfo then
		return
	end

	gohelper.setActive(self._goshareinfo, self._isShare)
	gohelper.setActive(self._btnshare, not self._isShare)
	self._playericon:onUpdateMO(self._playerMO)
	self._playericon:setShowLevel(false)

	self._txtplayername.text = self._playerMO.name
	self._txtplayerId.text = string.format("ID:%s", self._playerMO.userId)
	self._txtplanname.text = self._planName

	if self._isShare then
		self._txtsharecode.text = self._shareCode
		self._txtplaninfodesc.text = luaLang("room_layoutplan_share_notlack_desc")

		local isHasAll = self:_isHasAllBlockAndBuiling(self._planInfo)

		gohelper.setActive(self._goplaninfo, isHasAll)
		gohelper.setActive(self._gocomparing, not isHasAll and self._isCompareInfo)
		gohelper.setActive(self._gocompare, not isHasAll and not self._isCompareInfo)
	end

	self:_refreshLayoutPlan()
end

function RoomLayoutVisitPlan:_isHasAllBlockAndBuiling(planInfo)
	local packageNum, roleBirthdayNum, buildingNum, strList = RoomLayoutHelper.comparePlanInfo(planInfo)

	if packageNum > 0 or roleBirthdayNum > 0 or buildingNum > 0 then
		return false
	end

	return true
end

function RoomLayoutVisitPlan:_getDesStr(planInfo)
	local packageNum, roleBirthdayNum, buildingNum, strList = RoomLayoutHelper.comparePlanInfo(planInfo)

	if packageNum > 0 or roleBirthdayNum > 0 or buildingNum > 0 then
		local collStrList = {}

		self:_addCollStrList("room_layoutplan_blockpackage_lack", packageNum, collStrList)
		self:_addCollStrList("room_layoutplan_birthdayblock_lack", roleBirthdayNum, collStrList)
		self:_addCollStrList("room_layoutplan_building_lack", buildingNum, collStrList)

		local connchar = luaLang("room_levelup_init_and1")
		local lastConnchar = luaLang("room_levelup_init_and2")
		local collectStr = RoomLayoutHelper.connStrList(collStrList, connchar, lastConnchar)

		return string.format("<color=#AB1313>%s</color>", formatLuaLang("room_layoutplan_share_lack_desc", collectStr))
	end

	return luaLang("room_layoutplan_share_notlack_desc")
end

function RoomLayoutVisitPlan:_addCollStrList(langKey, needNum, collStrList)
	if needNum > 0 then
		table.insert(collStrList, formatLuaLang(langKey, needNum))
	end
end

function RoomLayoutVisitPlan:_refreshLayoutPlan()
	local isOpen = RoomLayoutController.instance:isOpen()

	if self._isShare then
		gohelper.setActive(self._gocopyunlock, self._isShare)
		gohelper.setActive(self._gocopylock, not self._isShare)
	end
end

function RoomLayoutVisitPlan:_showExpand(isShow)
	self._isShowExpand = isShow

	gohelper.setActive(self._goinformexpand, isShow)
	gohelper.setActive(self._btnmoremask, isShow)
end

function RoomLayoutVisitPlan:_compareRoom(isCompareInfo)
	self._isCompareInfo = isCompareInfo

	local scene = GameSceneMgr.instance:getCurScene()

	if scene and scene.camera then
		local cameraState = RoomEnum.CameraState.Overlook
		local cameraParam = {
			focusY = 0,
			focusX = 0,
			rotate = 0,
			zoom = scene.camera:getZoomInitValue(cameraState)
		}

		scene.camera:switchCameraState(cameraState, cameraParam, nil, self._onSwitchCameraDone, self)
	else
		self:_onSwitchCameraDone()
	end
end

function RoomLayoutVisitPlan:_onSwitchCameraDone()
	local param = {
		userId = self._playerMO.userId,
		shareCode = self._shareCode,
		isCompareInfo = self._isCompareInfo
	}
	local obInfo = self._curInfo

	RoomController.instance:enterRoom(RoomEnum.GameMode.VisitShare, nil, obInfo, param, nil, nil, true)
end

return RoomLayoutVisitPlan
