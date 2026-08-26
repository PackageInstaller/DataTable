-- chunkname: @modules/logic/mainuiswitch/view/SwitchMainUIReddotIcon.lua

module("modules.logic.mainuiswitch.view.SwitchMainUIReddotIcon", package.seeall)

local SwitchMainUIReddotIcon = class("SwitchMainUIReddotIcon", ListScrollCell)

function SwitchMainUIReddotIcon:init(go)
	self.go = IconMgr.instance:_getIconInstance(IconMgrConfig.UrlRedDotIcon, go)
	self._txtCount = gohelper.findChildText(self.go, "type2/#txt_count")
	self.typeGoDict = self:getUserDataTb_()

	for _, v in pairs(RedDotEnum.Style) do
		self.typeGoDict[v] = gohelper.findChild(self.go, "type" .. v)

		gohelper.setActive(self.typeGoDict[v], false)
	end
end

function SwitchMainUIReddotIcon:addEventListeners()
	MainUISwitchController.instance:registerCallback(MainUISwitchEvent.SwitchMainUI, self._onSwitchMainUI, self)
end

function SwitchMainUIReddotIcon:removeEventListeners()
	MainUISwitchController.instance:unregisterCallback(MainUISwitchEvent.SwitchMainUI, self._onSwitchMainUI, self)
end

function SwitchMainUIReddotIcon:_onSwitchMainUI(id)
	self._curMainUIId = id

	if self._showCb then
		self.show = self._showCb(self._showCbObj)

		self:showCurUIRedDot()

		return
	end

	self:defaultRefreshDot()
end

function SwitchMainUIReddotIcon:setId(id, uid, skinId)
	self:setMultiId({
		{
			id = id,
			uid = uid
		}
	})

	self._curMainUIId = skinId
end

function SwitchMainUIReddotIcon:setMultiId(infoList)
	self.infoDict = {}

	if infoList then
		for i, info in ipairs(infoList) do
			info.uid = info.uid or 0
			self.infoDict[info.id] = info.uid
		end
	end

	self.infoList = infoList
end

function SwitchMainUIReddotIcon:defaultRefreshDot()
	self.show = false

	if self.infoList then
		for i, info in ipairs(self.infoList) do
			self.show = RedDotModel.instance:isDotShow(info.id, info.uid)

			if self.show then
				self._txtCount.text = RedDotModel.instance:getDotInfoCount(info.id, info.uid)

				local type = RedDotConfig.instance:getRedDotCO(info.id).style
				local switchReddotCo = MainUISwitchConfig.instance:getUIReddotStyle(self._curMainUIId, info.id)

				self:showRedDot((switchReddotCo or nil) and switchReddotCo.style)

				return
			end
		end
	end
end

function SwitchMainUIReddotIcon:showRedDot(type)
	self._showType = type

	gohelper.setActive(self.go, self.show)

	if self.show then
		for _, v in pairs(RedDotEnum.Style) do
			gohelper.setActive(self.typeGoDict[v], type == v)
		end
	end
end

function SwitchMainUIReddotIcon:showCurUIRedDot(uiId)
	uiId = uiId or self._curMainUIId

	local style = MainUISwitchModel.instance:getUIReddotType(uiId)

	style = style or RedDotEnum.Style.Normal

	self:showRedDot(style)
end

function SwitchMainUIReddotIcon:setShowReddotCb(cb, cbObj)
	self._showCb = cb
	self._showCbObj = cbObj

	if self._showCb then
		self.show = self._showCb(self._showCbObj)
	end
end

function SwitchMainUIReddotIcon:refreshRedDot()
	if self._showCb then
		self.show = self._showCb(self._showCbObj)

		self:showCurUIRedDot()
	end
end

return SwitchMainUIReddotIcon
