-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/resourceDouble/ResourceDoubleWidget.lua

EVT_RESOURCEDOUBLE_REFRESH = "EVT_RESOURCEDOUBLE_REFRESH"
ResourceDoubleRefreshCommond = class("ResourceDoubleRefreshCommond", legs.Command, _M)

function ResourceDoubleRefreshCommond:execute(event)
	local resourceDoubleManager = ResourceDoubleManager:getInstance()

	resourceDoubleManager:refresh()
end

ResourceDoubleWidget = class("ResourceDoubleWidget", BaseWidget, _M)

function ResourceDoubleWidget:initialize(view, parent, getConfigFunc, notAutoRefresh)
	super.initialize(self, view)
	assert(parent ~= nil, "`parent` must NOT be nil")
	assert(getConfigFunc ~= nil, "`getConfigFunc` must NOT be nil")

	self._parent = parent
	self._getConfigFunc = getConfigFunc

	view:addTo(parent, 999)
	ccext.positeWithRelPosition(view, parent:getContentSize(), {
		1,
		1
	})
	view:atExit(function()
		self:dispose()
	end)
	self:refresh()

	if not notAutoRefresh then
		RedPointManager:getInstance():registerObject(self)
	end
end

function ResourceDoubleWidget:dispose()
	super.dispose(self)
end

function ResourceDoubleWidget:refresh()
	local view = self._view
	local config = self._getConfigFunc()

	if GameConfigs.closeResourceDoubleActivity then
		view:setVisible(false)

		return
	end

	view:setVisible(config ~= nil)

	if config ~= nil and view.refresh then
		view:refresh(config)
	end
end

ResourceDoubleIconType = {
	kYellow = 1,
	kRed = 2
}

function ResourceDoubleWidget.class:createTitleIcon(info, style)
	info = info or {}
	style = style or {}

	local mainWidget = ccui.Widget:create()

	mainWidget:setContentSize(cc.size(139, 52))
	mainWidget:setAnchorPoint(0.5, 0.5)

	if style.iconType then
		if not style.iconType then
			local backImgPath = "img_ExtraDrop_cishu_qipao.png"

			mainWidget.backImg = cc.Sprite:createWithSpriteFrameName(backImgPath)

			mainWidget.backImg:addTo(mainWidget):center(mainWidget:getContentSize())

			function mainWidget:refreshDescLabel(info)
				local strId = style.textId

				strId = strId or "Activity_Xianshi_Hong_1"

				local descStr = Strings:get(strId, {
					fontSize = 24,
					fontName = TTF_FONT_FZYH_M,
					factor = info.rate
				})

				if not self.descLabel then
					self.descLabel = ccui.RichText:createWithXML(descStr, {})

					self.descLabel:addTo(self.backImg):center(self.backImg:getContentSize()):offset(0, 3)
				else
					self.descLabel:setString(descStr)
				end
			end

			function mainWidget:refresh(info)
				self:refreshDescLabel(info)
			end

			mainWidget:refresh(info)

			return mainWidget
		end
	end
end

function ResourceDoubleWidget.class:createTipTitleIcon(info, style)
	info = info or {}
	style = style or {}

	local mainWidget = ccui.Widget:create()

	mainWidget:setContentSize(cc.size(139, 52))
	mainWidget:setAnchorPoint(0.5, 0.5)

	local iconType = "Activity_Xianshi_Hong_1"
	local backImgPath = "img_ExtraDrop_cishu_qipao.png"

	mainWidget.backImg = cc.Sprite:createWithSpriteFrameName(backImgPath)

	mainWidget.backImg:addTo(mainWidget):center(mainWidget:getContentSize())

	function mainWidget:refreshDescLabel(info)
		local strId = style.textId

		strId = strId or iconType == ResourceDoubleIconType.kYellow and "Activity_Xianshi_Huang_1" or "Activity_Xianshi_Hong_1"

		local descStr = Strings:get(strId, {
			fontSize = 24,
			fontName = TTF_FONT_FZYH_M,
			factor = info.rate
		})

		if not self.descLabel then
			self.descLabel = ccui.RichText:createWithXML(descStr, {})

			self.descLabel:addTo(self.backImg):center(self.backImg:getContentSize()):offset(0, 3)
		else
			self.descLabel:setString(descStr)
		end
	end

	function mainWidget:refresh(info)
		self:refreshDescLabel(info)
	end

	mainWidget:refresh(info)

	return mainWidget
end
