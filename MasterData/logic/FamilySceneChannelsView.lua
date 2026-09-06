-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyscene/view/FamilySceneChannelsView.lua

module("logic.extensions.familyscene.view.FamilySceneChannelsView", package.seeall)

local FamilySceneChannelsView = class("FamilySceneChannelsView", ViewComponent)

function FamilySceneChannelsView:ctor()
	FamilySceneChannelsView.super.ctor(self)
end

function FamilySceneChannelsView:buildUI()
	FamilySceneChannelsView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function FamilySceneChannelsView:bindEvents()
	FamilySceneChannelsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function FamilySceneChannelsView:unbindEvents()
	FamilySceneChannelsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FamilySceneChannelsView:onEnter()
	FamilySceneChannelsView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FamilySceneGetAllChannelInfosRes, self._onGetAllChannelInfosRes, self)
	self.addGEvent(self, GlobalNotify.FamilySceneSwitchChannelRes, self._onSwitchChannelRes, self)
	FamilySceneAgent.instance:sendPM_Cube_GetAllChannelInfosReq()
end

function FamilySceneChannelsView:onExit()
	FamilySceneChannelsView.super.onExit(self)
	self._scrollList:dispose()
end

function FamilySceneChannelsView:_onGetAllChannelInfosRes()
	self:_initChannels()
end

function FamilySceneChannelsView:_onSwitchChannelRes()
	self:close()
end

function FamilySceneChannelsView:_updateCell(view, cell, data, tag)
	local bg = goutil.findChild(cell, "bg")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local maxTip = goutil.findChild(cell, "maxTip")
	local curTip = goutil.findChild(cell, "curTip")
	local isSelf = self._curChannelId == checknumber(data.channelId)

	GameUtil.SetGray(bg, not isSelf and data.curEntityCount >= data.maxEntityCount)
	goutil.setActive(maxTip, not isSelf and data.curEntityCount >= data.maxEntityCount)
	goutil.setActive(curTip, isSelf)

	txtDesc.text = string.format("%s(<color=#%s>%d</color>/%d)", data.name, ColorConst.Yellow2, data.curEntityCount, data.maxEntityCount)

	GameUtil.addClickHandler(bg, function()
		if not isSelf then
			if data.curEntityCount < data.maxEntityCount then
				FamilySceneAgent.instance:sendPM_Cube_SwitchChannelReq(checknumber(data.channelId))
			else
				FloatWordMgr.instance:show("当前房间已满")
			end
		else
			FloatWordMgr.instance:show("已在当前房间")
		end
	end)
end

function FamilySceneChannelsView:clearCell(cell)
	return
end

function FamilySceneChannelsView:_initChannels()
	self._curChannelId = FamilySceneModel.instance:getCurChannelId()

	local datas = FamilySceneModel.instance:getCurChannels()

	self._scrollList:reloadData(datas)
end

return FamilySceneChannelsView
