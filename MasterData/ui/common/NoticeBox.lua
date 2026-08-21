-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\NoticeBox.lua

local MsgReceiver = require("System/MsgReceiver")
local UIConst = UIConst
local strClassName = "NoticeBox"
local NoticeBox = Class(strClassName, UIControls.Window)

function NoticeBox:ctor()
	self:initUI()

	self.mMsgDatas = {}
end

function NoticeBox:destroy()
	self.receiver:destroy()
	NoticeBox.super.destroy(self)
end

function NoticeBox:initUI()
	self.localizationComponent = self:getController():GetCom(UIConst.ControlTypeLocalizationComponent, "MsgPanel/Text")
	self.core = self:getController():GetCom(UIConst.ControlTypeMsgMovePool, "Content")
	self.receiver = MsgReceiver({
		Const.CHANNEL_NOTICE
	})
	self.receiver.mEventReceive = Functor(self.onMsgReceive, self)
end

function NoticeBox:onShowReward(attrs, items, skills, weapons, rune, prestige, specials, gvgitems)
	local rewards = {}

	if attrs then
		local exp = 0
		local storeExp = 0

		for i, attrUnit in ipairs(attrs) do
			if attrUnit.type == Const.ROLE_ATTR_TYPE_EXP then
				exp = attrUnit.value
			elseif attrUnit.type == Const.ROLE_ATTR_TYPE_STORE_EXP then
				storeExp = attrUnit.value
			elseif attrUnit.value > 0 then
				local iconConfig = UIConst.FUND_CONFIG[attrUnit.type]

				if iconConfig then
					local msgText = utils.format(Lang.get(30218), attrUnit.value, iconConfig[3])

					self:showNotice(msgText, iconConfig[1], iconConfig[2], AttrSFXPath)
					MsgManager.receive(msgText, Const.CHANNEL_PERSON)
				end
			end
		end

		if exp > 0 or storeExp ~= 0 then
			local msgText = ""

			if storeExp > 0 then
				msgText = string.format(Lang.get(30219), storeExp)

				self:showNotice(msgText, "Atlas/CommonAtlas/IconAtlas/CurrencyAtlas", "IconXP", AttrSFXPath)
			elseif storeExp < 0 then
				msgText = utils.format(Lang.get(30220), exp, -storeExp)

				self:showNotice(msgText, "Atlas/CommonAtlas/IconAtlas/CurrencyAtlas", "IconXP", AttrSFXPath)
			else
				msgText = string.format(Lang.get(30221), exp)

				self:showNotice(msgText, "Atlas/CommonAtlas/IconAtlas/CurrencyAtlas", "IconXP", AttrSFXPath)
			end

			MsgManager.receive(msgText, Const.CHANNEL_PERSON)
		end
	end

	for index, containers in pairs({
		items,
		skills,
		weapons,
		rune,
		specials,
		gvgitems
	}) do
		for i, item in ipairs(containers) do
			local clientItem = BaseObject.GetObject(item.id)

			if clientItem then
				local msgText = string.format(Lang.get(30222), clientItem:getQualityName())

				if index == 1 or index == 5 then
					msgText = msgText .. " ×" .. item.num
				end

				local path = clientItem:getIconPath()

				if path then
					self:showNotice(msgText, path[1], path[2], AttrSFXPath)
				else
					self:showNotice(msgText, nil, nil, AttrSFXPath)
				end

				MsgManager.receive(msgText, Const.CHANNEL_PERSON)
			end
		end
	end
end

function NoticeBox:showNotice(msgText, iconFilePath, iconSpriteName, sfxPath)
	if iconFilePath == nil then
		iconFilePath = ""
		iconSpriteName = ""
	end

	if sfxPath == nil then
		sfxPath = ""
	end

	self.core:ShowMsg(msgText, iconFilePath, iconSpriteName, sfxPath)
end

function NoticeBox:onMsgReceive(msgData)
	if self.localizationComponent then
		self.localizationComponent.close = true
	end

	self:showNotice(msgData.content)
end

function NoticeBox:onHide()
	self.BgNoticeImg:setVisible(false)
end

return NoticeBox
