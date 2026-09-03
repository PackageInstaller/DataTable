-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleGuideSpeakWidget.lua

BattleGuideSpeakWidget = class("BattleGuideSpeakWidget", BaseWidget)

function BattleGuideSpeakWidget:initialize(view, args, callback)
	super.initialize(self, view)

	self._callback = callback
	self._data = args
end

function BattleGuideSpeakWidget:dispose()
	super.dispose(self)
end

function BattleGuideSpeakWidget:setViewContext(context)
	self._viewContext = context

	self:setupView()
end

function BattleGuideSpeakWidget:setupView()
	local view = self:getView()
	local bgLeft = view:getChildByFullName("bg")
	local textLeft = view:getChildByFullName("text")
	local iconLeft = view:getChildByFullName("icon")
	local bgRight = view:getChildByFullName("bg_1")
	local textRight = view:getChildByFullName("text_1")
	local iconRight = view:getChildByFullName("icon_1")
	local content = self._data.content

	if self._data.style == "right" then
		bgLeft:setVisible(false)
		textLeft:setVisible(false)
		iconLeft:setVisible(false)
		bgRight:setVisible(true)
		textRight:setVisible(true)
		iconRight:setVisible(true)
		textRight:setString(content)
		iconRight:loadTexture(self._data.iconPath)
	else
		textLeft:setString(content)
		iconLeft:loadTexture(self._data.iconPath)
	end
end
