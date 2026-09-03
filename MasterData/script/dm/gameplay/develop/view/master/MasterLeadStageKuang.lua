-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterLeadStageKuang.lua

MasterLeadStageKuang = class("MasterLeadStageKuang", BaseWidget, _M)

local iconOffsetInfo = {
	[0] = {
		frame2 = "bustframe13_4",
		frame1 = "bustframe13_3"
	},
	{
		frame2 = "bustframe13_4",
		frame1 = "bustframe13_3"
	},
	{
		frame2 = "bustframe13_4",
		frame1 = "bustframe13_3"
	},
	{
		frame2 = "bustframe13_4",
		frame1 = "bustframe13_3"
	},
	{
		frame2 = "bustframe13_8",
		frame1 = "bustframe13_7"
	},
	{
		frame2 = "bustframe13_8",
		frame1 = "bustframe13_7"
	},
	{
		frame2 = "bustframe13_8",
		frame1 = "bustframe13_7"
	},
	{
		frame2 = "bustframe13_8",
		frame1 = "bustframe13_7"
	},
	{
		frame2 = "bustframe13_10",
		frame1 = "bustframe13_9"
	}
}

function MasterLeadStageKuang.class:createWidgetNode()
	local resFile = "asset/ui/MasterLeadStageKuangNode.csb"

	return cc.CSLoader:createNode(resFile)
end

function MasterLeadStageKuang:initialize(view, data)
	super.initialize(self, view)

	self._leadStageLevel = data.stageLevel
	self._leadStageId = data.stageId
	self._modelId = data.modelId

	self:initSubviews(view)
	self:refreshInfo()
end

function MasterLeadStageKuang:dispose()
	super.dispose(self)
end

function MasterLeadStageKuang:initSubviews(view)
	self._view = view
	self._panel = self._view:getChildByName("panel")
	self._imgKuang = self._panel:getChildByName("img_kuang")
	self._imgZhezhao = self._panel:getChildByFullName("img_zhezhao")
	self._heroIcon = self._panel:getChildByFullName("node_heroBg")
	self._heroIconBg = self._panel:getChildByFullName("node_heroBg")
	self._imgIcon = self._panel:getChildByFullName("Image_icon")
	self._text = self._panel:getChildByFullName("Text_104")
end

function MasterLeadStageKuang:refreshInfo()
	local mid

	if self._leadStageId == "" then
		self._imgKuang:loadTexture("bg_leadstage_kuang09.png", ccui.TextureResType.plistType)
		self._imgZhezhao:setVisible(false)
		self._text:setVisible(false)
		self._imgIcon:setVisible(false)

		mid = self._modelId
	else
		local info = ConfigReader:getRecordById("MasterLeadStage", self._leadStageId)

		self._imgKuang:loadTexture(info.Frame .. ".png", ccui.TextureResType.plistType)
		self._imgZhezhao:loadTexture(info.FrameShade .. ".png", ccui.TextureResType.plistType)
		self._text:setString(Strings:get(info.RomanNum) .. Strings:get(info.StageName))
		self._text:setTextColor(GameStyle:getLeadStageColor(self._leadStageLevel))
		self._imgIcon:loadTexture(info.Icon, ccui.TextureResType.plistType)
		self._imgIcon:setScale(self._leadStageLevel == 8 and 0.7 or self._leadStageLevel == 1 and 0.8 or 1)
		self._imgIcon:ignoreContentAdaptWithSize(true)
		self._imgZhezhao:ignoreContentAdaptWithSize(true)

		mid = info.ModelId
	end

	local info = {}

	info.id = mid
	info.frameId = iconOffsetInfo[self._leadStageLevel].frame2

	local icon = IconFactory:createRoleIconSpriteNew(info)

	icon:setAnchorPoint(cc.p(0, 0))
	icon:addTo(self._heroIconBg)
	icon:setOpacity(50)

	if self._leadStageLevel == 8 then
		icon:offset(0, 0)
		self._imgKuang:setPositionY(470)
		self._imgZhezhao:setPositionY(470)
	else
		icon:offset(0, 2)
	end

	local info = {}

	info.id = mid
	info.frameId = iconOffsetInfo[self._leadStageLevel].frame1

	local icon = IconFactory:createRoleIconSpriteNew(info)

	icon:setAnchorPoint(cc.p(0, 0))
	icon:addTo(self._heroIcon)

	if self._leadStageLevel == 8 then
		icon:offset(0, 10)
	else
		icon:offset(0, 2)
	end
end

function MasterLeadStageKuang:show()
	self._view:setVisible(true)
end

function MasterLeadStageKuang:hide()
	self._view:setVisible(false)
end
