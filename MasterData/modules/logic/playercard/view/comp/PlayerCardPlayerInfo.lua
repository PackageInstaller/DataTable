-- chunkname: @modules/logic/playercard/view/comp/PlayerCardPlayerInfo.lua

module("modules.logic.playercard.view.comp.PlayerCardPlayerInfo", package.seeall)

local PlayerCardPlayerInfo = class("PlayerCardPlayerInfo", BaseView)

function PlayerCardPlayerInfo:init(go)
	self.viewGO = go

	self:onInitView()
end

function PlayerCardPlayerInfo:canOpen()
	self:onOpen()
	self:addEvents()
end

function PlayerCardPlayerInfo:onInitView()
	self.go = gohelper.findChild(self.viewGO, "root/main/playerinfo")
	self._simageheadicon = gohelper.findChildSingleImage(self.go, "ani/headframe/#simage_headicon")
	self._btnheadicon = gohelper.findChildButtonWithAudio(self.go, "ani/headframe/#simage_headicon")
	self._goframenode = gohelper.findChild(self.go, "ani/headframe/#simage_headicon/#go_framenode")
	self._txtlevel = gohelper.findChildText(self.go, "ani/lv/#txt_level")
	self._txtplayerid = gohelper.findChildText(self.go, "ani/#txt_playerid")
	self._btnplayerid = gohelper.findChildButtonWithAudio(self.go, "ani/#txt_playerid/#btn_playerid")
	self._txtname = gohelper.findChildText(self.go, "ani/#txt_name")
end

function PlayerCardPlayerInfo:addEvents()
	self._btnplayerid:AddClickListener(self._btnplayeridOnClick, self)
	self._btnheadicon:AddClickListener(self._changeIcon, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.UpdateCardInfo, self.onRefreshView, self)
	self.addEventCb(self, PlayerController.instance, PlayerEvent.SetPortrait, self.onRefreshView, self)
end

function PlayerCardPlayerInfo:removeEvents()
	self._btnplayerid:RemoveClickListener()
	self._btnheadicon:RemoveClickListener()
end

function PlayerCardPlayerInfo:_changeIcon()
	if self:isPlayerSelf() then
		ViewMgr.instance:openView(ViewName.IconTipView)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Magazinespage)
	end
end

function PlayerCardPlayerInfo:onOpen()
	local param = self.viewParam

	self.userId = param.userId

	self:updateBaseInfo()
end

function PlayerCardPlayerInfo:getCardInfo()
	return PlayerCardModel.instance:getCardInfo(self.userId)
end

function PlayerCardPlayerInfo:isPlayerSelf()
	local cardInfo = self:getCardInfo()

	return cardInfo and cardInfo:isSelf()
end

function PlayerCardPlayerInfo:getPlayerInfo()
	local cardInfo = self:getCardInfo()

	return cardInfo and cardInfo:getPlayerInfo()
end

function PlayerCardPlayerInfo:_btnplayeridOnClick()
	local info = self:getPlayerInfo()

	if not info then
		return
	end

	self._txtplayerid.text = info.userId

	ZProj.UGUIHelper.CopyText(self._txtplayerid.text)

	self._txtplayerid.text = string.format("ID:%s", info.userId)

	GameFacade.showToast(ToastEnum.ClickPlayerId)
end

function PlayerCardPlayerInfo:onRefreshView()
	self:updateBaseInfo()
end

function PlayerCardPlayerInfo:updateBaseInfo()
	local info = self:getPlayerInfo()

	if not info then
		return
	end

	self._txtname.text = info.name
	self._txtplayerid.text = string.format("ID:%s", info.userId)
	self._txtlevel.text = info.level

	local config = lua_item.configDict[info.portrait]

	self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simageheadicon)

	self._liveHeadIcon:setLiveHead(info.portrait)

	local effectArr = string.split(config.effect, "#")

	if #effectArr > 1 then
		if config.id == tonumber(effectArr[#effectArr]) then
			gohelper.setActive(self._goframenode, true)

			if not self.frame and not self._loader then
				self._loader = MultiAbLoader.New()

				local framePath = "ui/viewres/common/effect/frame.prefab"

				self._loader:addPath(framePath)
				self._loader:startLoad(self._onLoadCallback, self)
			end
		end
	else
		gohelper.setActive(self._goframenode, false)
	end
end

function PlayerCardPlayerInfo:_onLoadCallback()
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

function PlayerCardPlayerInfo:onDestroy()
	self._simageheadicon:UnLoadImage()

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self:removeEvents()
end

return PlayerCardPlayerInfo
