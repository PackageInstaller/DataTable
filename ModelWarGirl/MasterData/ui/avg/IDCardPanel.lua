-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\AVG\\IDCardPanel.lua

local strClassName = "IDCardPanel"
local IDCardPanel = Class(strClassName, UIControls.Child)

function IDCardPanel:ctor()
	self:initUI()
end

function IDCardPanel:initUI()
	self.nameText = UIControls.Label(self, "InfoPanel/TextName")
	self.idText = UIControls.Label(self, "InfoPanel/TextID")
	self.addressText = UIControls.Label(self, "InfoPanel/TextAddress")
	self.descriptionText = UIControls.Label(self, "InfoPanel/DesPanel/TextDes")
	self.orgText = UIControls.Label(self, "InfoPanel/TextOrg")
	self.rolePortrait = UIControls.AvgRole(self, "InfoPanel/MaskHero/HeroPaenl")
	self.idCardPanelAni = UIControls.UIAni(self, "")

	self.idCardPanelAni:addEventFinish(self._idCardAniEnd, UIConst.ROLEIMAGE_SHOWTYPE_HERO_GET)
end

function IDCardPanel:showData(id)
	local ResTalkIDCard = require("ClientData/ResTalkIDCard")
	local ResTalkNpc = require("ClientData/ResTalkNpc")
	local data = ResTalkIDCard[id]

	if data then
		local npcData = ResTalkNpc[data.hero_id]

		self.nameText:setText(npcData.name)
		self.idText:setText(data.number)
		self.addressText:setText(data.address)
		self.descriptionText:setText(data.description)
		self.orgText:setText(data.org_description)
		self.rolePortrait:showRole(npcData.hero_id)
		self.rolePortrait:setAbsPosition(npcData.head_pos[1], npcData.head_pos[2])

		local flip = npcData.head_flip

		if flip then
			self.rolePortrait:setScaleAndFlip(-1 * npcData.head_scale)
		else
			self.rolePortrait:setScaleAndFlip(npcData.head_scale)
		end

		if data.emoji then
			self.rolePortrait:showEmoji(data.emoji)
		end
	end

	self.idCardPanelAni:startAni("ShowAvgIDCardPanel", true)
end

function IDCardPanel:_idCardAniEnd(animCon, animName)
	local talkBox = UIManager.tryGetUI("talkBox")

	if talkBox then
		talkBox:_idCardAniEnd(animCon, animName)
	end
end

function IDCardPanel:Close()
	self.idCardPanelAni:startAni("CloseAvgIDCardPanel")
end

return IDCardPanel
