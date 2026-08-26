-- chunkname: @modules/ugui/icon/common/CommonPlayerIcon.lua

module("modules.ugui.icon.common.CommonPlayerIcon", package.seeall)

local CommonPlayerIcon = class("CommonPlayerIcon", ListScrollCell)

function CommonPlayerIcon:init(go)
	self.go = go
	self.tr = go.transform
	self._simageheadicon = gohelper.findChildSingleImage(self.go, "bg/#simage_headicon")
	self._goframenode = gohelper.findChild(self.go, "bg/#simage_headicon/#go_framenode")
	self._golevel = gohelper.findChild(self.go, "#go_level")
	self._imgLevelbg = gohelper.findChildImage(self.go, "#go_level")
	self._txtlevel = gohelper.findChildText(self.go, "#go_level/#txt_level")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "#btn_click")
	self._loader = MultiAbLoader.New()
	self._enableClick = true
end

function CommonPlayerIcon:addEventListeners()
	self._btnclick:AddClickListener(self._onClick, self)
end

function CommonPlayerIcon:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function CommonPlayerIcon:setEnableClick(enable)
	self._enableClick = enable
end

function CommonPlayerIcon:isSelectInFriend(isSelect)
	self._isSelectInFriend = isSelect
end

function CommonPlayerIcon:setPlayerIconGray(isGray)
	self._liveHeadIcon:setGray(isGray)
end

function CommonPlayerIcon:setScale(scale)
	transformhelper.setLocalScale(self.tr, scale, scale, scale)
end

function CommonPlayerIcon:setPos(paramName, posX, posY)
	if not self[paramName] then
		return
	end

	recthelper.setAnchor(self[paramName].transform, posX, posY)
end

function CommonPlayerIcon:_onClick()
	if not self._enableClick then
		return
	end

	local param = {}

	param.mo = self._mo
	param.worldPos = self._simageheadicon.transform.position

	if self._isSelectInFriend then
		param.isSelectInFriend = self._isSelectInFriend
	end

	param.hideRoomBtn = self.hideRoomBtn

	ViewMgr.instance:openView(self._playerInfoViewName or ViewName.PlayerInfoView, param)
end

function CommonPlayerIcon:setPlayerInfoViewName(name)
	self._playerInfoViewName = name
end

function CommonPlayerIcon:_refreshUI()
	self._txtlevel.text = "Lv." .. self._mo.level
	self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simageheadicon)

	self._liveHeadIcon:setLiveHead(self._mo.portrait)

	local myUserId = PlayerModel.instance:getMyUserId()

	if self._mo.userId == myUserId then
		self.addEventCb(self, PlayerController.instance, PlayerEvent.ChangePlayerinfo, self._changePlayerinfo, self)
	else
		self.removeEventCb(self, PlayerController.instance, PlayerEvent.ChangePlayerinfo, self._changePlayerinfo, self)
	end
end

function CommonPlayerIcon:_onLoadCallback()
	self.isloading = false

	local framePrefab = self._loader:getFirstAssetItem():GetResource()

	gohelper.clone(framePrefab, self._goframenode, "frame")

	self.frame = gohelper.findChild(self._goframenode, "frame")

	local img = self.frame:GetComponent(gohelper.Type_Image)

	img.enabled = false

	local iconwidth = recthelper.getWidth(self._simageheadicon.transform)
	local framenodewidth = recthelper.getWidth(self.frame.transform)
	local scale = 1.41 * (iconwidth / framenodewidth)

	transformhelper.setLocalScale(self.frame.transform, scale, scale, 1)
end

function CommonPlayerIcon:_changePlayerinfo()
	self._mo = SocialModel.instance:getPlayerMO(self._mo.userId)

	self:_refreshUI()
end

function CommonPlayerIcon:onUpdateMO(mo)
	self._mo = mo

	self:_refreshUI()
	self:refreshFrame()
end

function CommonPlayerIcon:refreshFrame()
	local config = lua_item.configDict[self._mo.portrait]
	local effectArr = string.split(config.effect, "#")

	if #effectArr > 1 then
		if config.id == tonumber(effectArr[#effectArr]) then
			gohelper.setActive(self._goframenode, true)

			if not self.frame and not self.isloading then
				self.isloading = true

				local framePath = "ui/viewres/common/effect/frame.prefab"

				self._loader:addPath(framePath)
				self._loader:startLoad(self._onLoadCallback, self)
			end
		end
	else
		gohelper.setActive(self._goframenode, false)
	end
end

function CommonPlayerIcon:setMOValue(userId, name, level, portrait, time, bg)
	local info = {}

	info.userId = userId
	info.name = name
	info.level = level
	info.portrait = portrait
	info.time = time
	info.bg = bg
	self._mo = SocialPlayerMO.New()

	self._mo:init(info)
	self:_refreshUI()
	self:setShowLevel(true)
end

function CommonPlayerIcon:setShowLevel(isShow)
	gohelper.setActive(self._golevel, isShow)
end

function CommonPlayerIcon:getLevelBg()
	return self._imgLevelbg
end

function CommonPlayerIcon:setHideRoomBtn(isHide)
	self.hideRoomBtn = isHide
end

function CommonPlayerIcon:onDestroy()
	self.removeEventCb(self, PlayerController.instance, PlayerEvent.ChangePlayerinfo, self._changePlayerinfo, self)

	if self._simageheadicon then
		self._simageheadicon:UnLoadImage()

		self._simageheadicon = nil
	end

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

return CommonPlayerIcon
