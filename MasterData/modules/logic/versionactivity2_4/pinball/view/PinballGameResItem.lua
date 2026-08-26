-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballGameResItem.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballGameResItem", package.seeall)

local PinballGameResItem = class("PinballGameResItem", LuaCompBase)

function PinballGameResItem:init(go)
	self._txtNum = gohelper.findChildTextMesh(go, "#txt_num")
	self._imageicon = gohelper.findChildImage(go, "#image_icon")
	self._imageiconbg = gohelper.findChildImage(go, "#image_iconbg")
	self._imageball = gohelper.findChildImage(go, "#image_ball")
	self._anim = gohelper.findChildAnim(go, "")
end

function PinballGameResItem:addEventListeners()
	PinballController.instance:registerCallback(PinballEvent.GameResChange, self._refreshUI, self)
end

function PinballGameResItem:removeEventListeners()
	PinballController.instance:unregisterCallback(PinballEvent.GameResChange, self._refreshUI, self)
end

local dict = {
	[PinballEnum.ResType.Wood] = "v2a4_tutushizi_resourcebg_1",
	[PinballEnum.ResType.Mine] = "v2a4_tutushizi_resourcebg_3",
	[PinballEnum.ResType.Stone] = "v2a4_tutushizi_resourcebg_2",
	[PinballEnum.ResType.Food] = "v2a4_tutushizi_resourcebg_4"
}
local dict2 = {
	[PinballEnum.ResType.Wood] = "v2a4_tutushizi_smallball_3",
	[PinballEnum.ResType.Mine] = "v2a4_tutushizi_smallball_1",
	[PinballEnum.ResType.Stone] = "v2a4_tutushizi_smallball_4",
	[PinballEnum.ResType.Food] = "v2a4_tutushizi_smallball_2"
}

function PinballGameResItem:setData(data)
	self._resType = data

	self:_refreshUI()

	local resCo = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][self._resType]

	if not resCo then
		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(self._imageicon, resCo.icon)
	UISpriteSetMgr.instance:setAct178Sprite(self._imageiconbg, dict[self._resType])
	UISpriteSetMgr.instance:setAct178Sprite(self._imageball, dict2[self._resType])
end

function PinballGameResItem:_refreshUI()
	local num = PinballModel.instance:getGameRes(self._resType)

	if self._cacheNum and num > self._cacheNum and (not self._playAnimDt or UnityEngine.Time.realtimeSinceStartup - self._playAnimDt > 2) then
		self._anim:Play("refresh", 0, 0)

		self._playAnimDt = UnityEngine.Time.realtimeSinceStartup
	end

	self._cacheNum = num
	self._txtNum.text = num
end

return PinballGameResItem
