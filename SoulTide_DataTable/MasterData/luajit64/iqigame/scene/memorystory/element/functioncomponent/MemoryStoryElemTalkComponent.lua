-- chunkname: @IQIGame\\Scene\\MemoryStory\\Element\\FunctionComponent\\MemoryStoryElemTalkComponent.lua

local MemoryStoryElemBaseComponent = require("IQIGame.Scene.MemoryStory.Element.FunctionComponent.MemoryStoryElemBaseComponent")
local m = {}

m = extend(MemoryStoryElemBaseComponent, m)

function m.New(view)
	local obj = Clone(m)

	obj:__OnInit(view)

	return obj
end

function m:__OnInit(view)
	self:__Init(view)

	self.leftTipText = self.goLeftText.gameObject:GetComponent("Text")
	self.rightTipText = self.goRightText.gameObject:GetComponent("Text")

	self:HideTalk()
end

function m:HideTalk()
	self.goLeftRoot.gameObject:SetActive(false)
	self.goRightRoot.gameObject:SetActive(false)
end

function m:ShowLeftTalk(content)
	self.leftTipText.text = content

	self.goRightRoot.gameObject:SetActive(false)
	self.goLeftRoot.gameObject:SetActive(true)
end

function m:ShowRightTalk(content)
	self.rightTipText.text = content

	self.goLeftRoot.gameObject:SetActive(false)
	self.goRightRoot.gameObject:SetActive(true)
end

function m:OnDestroy()
	self:HideTalk()

	self.leftTipText = nil
	self.rightTipText = nil

	self:__BaseDestroy()
end

return m
