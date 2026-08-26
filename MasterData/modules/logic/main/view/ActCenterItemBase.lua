-- chunkname: @modules/logic/main/view/ActCenterItemBase.lua

module("modules.logic.main.view.ActCenterItemBase", package.seeall)

local ActCenterItemBase = class("ActCenterItemBase", LuaCompBase)

function ActCenterItemBase:init(go)
	self:__onInit()

	self.go = go
	self._transform = go.transform
	self._imgGo = gohelper.findChild(go, "bg")
	self._imgitem = gohelper.findChildImage(go, "bg")
	self._btnitem = gohelper.findChildClick(go, "bg")
	self._goactivityreddot = gohelper.findChild(go, "go_activityreddot")
	self._txttheme = gohelper.findChildText(go, "txt_theme")
	self._godeadline = gohelper.findChild(go, "#go_deadline")
	self._txttime = gohelper.findChildText(go, "#go_deadline/#txt_time")
	self._act_iconbgGo = gohelper.findChild(go, "act_iconbg")
	self._act_iconbg_effGo = gohelper.findChild(go, "act_iconbg_eff")
	self._goexpup = gohelper.findChild(self.go, "#go_expup")
	self._txtgm = gohelper.findChildText(go, "txt_gm")
	self._festivalAtmosphereComp = MonoHelper.addNoUpdateLuaComOnceToGo(go, FestivalAtmosphereComp, self)

	self:_initActEff()
	self:onInit(go)
	self:_addEvent()
	gohelper.setActive(go, true)
	self:_gm_Show_Activitycenter()
end

function ActCenterItemBase:onDestroyView()
	self:_removeEvent()
	self:onDestroy()
	gohelper.destroy(self.go)
	self:__onDispose()
	self._festivalAtmosphereComp:onDestroy()
end

function ActCenterItemBase:_addEvent()
	self._btnitem:AddClickListener(self.onClick, self)
	self:onAddEvent()
end

function ActCenterItemBase:_removeEvent()
	self._btnitem:RemoveClickListener()
	self:onRemoveEvent()
end

function ActCenterItemBase:_onOpen(...)
	self:onOpen(...)
end

function ActCenterItemBase:refresh(...)
	self:_gm_Show_Activitycenter()

	if not self.__isFirst then
		self:_onOpen(...)

		self.__isFirst = true
	end

	self:onRefresh(...)
end

function ActCenterItemBase:_addNotEventRedDot(cb, cbObj)
	self._redDot = RedDotController.instance:addNotEventRedDot(self._goactivityreddot, cb, cbObj)
end

function ActCenterItemBase:setReddotShowType(showType)
	if self._redDot then
		self._redDot:setShowType(showType)
	end
end

function ActCenterItemBase:isShowRedDot()
	return self._redDot and self._redDot.isShowRedDot
end

function ActCenterItemBase:_setMainSprite(spriteName)
	UISpriteSetMgr.instance:setMainSprite(self._imgitem, spriteName)
end

function ActCenterItemBase:setSiblingIndex(index)
	self._transform:SetSiblingIndex(index)
end

function ActCenterItemBase:_refreshRedDot()
	if self._redDot then
		self._redDot:refreshRedDot()
	end
end

function ActCenterItemBase:setCustomData(data)
	self._data = data
end

function ActCenterItemBase:getCustomData()
	return self._data
end

function ActCenterItemBase:getMainActAtmosphereConfig()
	return ActivityConfig.instance:getMainActAtmosphereConfig()
end

function ActCenterItemBase:isShowActivityEffect(forceUpdate)
	if self._isShowActivityEffect == nil or forceUpdate then
		self._isShowActivityEffect = ActivityModel.showActivityEffect()
	end

	return self._isShowActivityEffect
end

function ActCenterItemBase:_initActEff()
	local isShow = self:isShowActivityEffect()

	self._festivalAtmosphereComp:setFestival(isShow)
	self:_setActive_act_iconbg(isShow and ActivityModel.checkIsShowFxVisible())
end

function ActCenterItemBase:setFestival(isFestival)
	self._festivalAtmosphereComp:setFestival(isFestival)
end

function ActCenterItemBase:getActBtnPrefixIconName(isShow, iconName)
	if isShow then
		return ActivityEnum.ActBtnPrefix.mainView .. iconName
	end

	return iconName
end

function ActCenterItemBase:onInit(go)
	return
end

function ActCenterItemBase:onDestroy()
	return
end

function ActCenterItemBase:onOpen()
	return
end

function ActCenterItemBase:onRefresh(...)
	self:refreshRedDot()
end

function ActCenterItemBase:onAddEvent()
	return
end

function ActCenterItemBase:onRemoveEvent()
	return
end

function ActCenterItemBase:_gm_Show_Activitycenter()
	gohelper.setActive(self._txtgm.gameObject, false)

	local isOpenGM = GMController.instance:isOpenGM() and GMSubViewActivity.isOnOpenAllActCenter

	if not isOpenGM then
		return
	end

	local dict = self:_gm_getActIdDict()
	local list = {}
	local gmTxt = ""

	if not dict then
		return
	end

	for id, _ in pairs(dict) do
		table.insert(list, id)
	end

	table.sort(list, function(a, b)
		return tonumber(a) < tonumber(b)
	end)

	for _, id in ipairs(list) do
		local txt = string.format("<color=#BDB4A9>[%s]</color>", id)
		local list2 = dict[id]

		table.sort(list2, function(a, b)
			return tonumber(a) < tonumber(b)
		end)

		for _, actId in ipairs(list2) do
			txt = txt .. " " .. actId
		end

		gmTxt = gmTxt .. txt .. "\n"
	end

	self:showGm(gmTxt)
end

function ActCenterItemBase:_gm_getActIdDict()
	local list = self:_gm_ActIds()

	if not list then
		return
	end

	local dict = {}

	for _, actId in ipairs(list) do
		local id = string.sub(tostring(actId), 2, 3)

		dict[id] = dict[id] or {}

		table.insert(dict[id], actId)
	end

	return dict
end

function ActCenterItemBase:_gm_ActIds()
	if not self._data then
		return
	end

	if not self.onGetActId then
		return
	end

	return {
		self:onGetActId()
	}
end

function ActCenterItemBase:showGm(gmTxt)
	if not self._txtgm then
		return
	end

	if string.nilorempty(gmTxt) then
		gohelper.setActive(self._txtgm.gameObject, false)
	else
		gohelper.setActive(self._txtgm.gameObject, true)

		self._txtgm.text = gmTxt
	end
end

function ActCenterItemBase:onClick()
	assert(false, "please override 'onClick' function!!")
end

function ActCenterItemBase:_setActive_act_iconbg(isActive)
	gohelper.setActive(self._act_iconbgGo, isActive)
	gohelper.setActive(self._act_iconbg_effGo, isActive)
end

function ActCenterItemBase:_checkRedotShowType(reddotId)
	local curMainUIId = MainUISwitchModel.instance:getCurUseUI()
	local switchReddotCo = MainUISwitchConfig.instance:getUIReddotStyle(curMainUIId, reddotId)

	if switchReddotCo then
		local type = switchReddotCo.style

		if type then
			self:setReddotShowType(type)
		end
	else
		self:setReddotShowType(RedDotEnum.Style.Normal)
	end
end

return ActCenterItemBase
