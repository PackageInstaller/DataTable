-- chunkname: @IQIGame\\UI\\Lottery\\LotteryTipsView\\LotteryTipsView1.lua

local UIViewObjectPool = require("IQIGame/UI/Common/UIViewObjectPool")
local LotteryTipsView = require("IQIGame/UI/Lottery/LotteryTipsView/LotteryTipsView")
local LotteryTipsView1_Item = {}

function LotteryTipsView1_Item.New(view)
	local obj = Clone(LotteryTipsView1_Item)

	obj:__Init(view)

	return obj
end

function LotteryTipsView1_Item:__Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)
end

function LotteryTipsView1_Item:Show(data)
	self.view.gameObject:SetActive(true)

	self.titleText:GetComponent("Text").text = data.Title
	self.content:GetComponent("Text").text = data.Text
end

function LotteryTipsView1_Item:Hide()
	self.view.gameObject:SetActive(false)
end

function LotteryTipsView1_Item:Dispose()
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

local LotteryTipsView1 = Clone(LotteryTipsView)

LotteryTipsView1.templatePool = nil

function LotteryTipsView1.New(view)
	local obj = Clone(LotteryTipsView1)

	obj:Init(view)

	return obj
end

function LotteryTipsView1:__Init()
	LuaCodeInterface.BindOutlet(self.view, self)
	self.template.gameObject:SetActive(false)

	self.templatePool = UIViewObjectPool.New(self.template, nil, function(view)
		return LotteryTipsView1_Item.New(view)
	end)
end

function LotteryTipsView1:__Show()
	self.scrollContent.transform.localPosition = Vector3.zero

	self.templatePool:ForItems(function(_item)
		_item:Hide()
	end)

	local cardJackpotShowData = LotteryModule.GetCardJackpotShowConfig(self.cardJackpotID)

	if cardJackpotShowData == nil then
		return
	end

	ForArray(cardJackpotShowData.ShowInstruction, function(_, _id)
		local instructionData = CfgCardJackpotInstructionTable[_id]

		if instructionData == nil then
			return
		end

		local item = self.templatePool:GetFree(function(_item)
			return not _item.view.gameObject.activeSelf
		end)

		item:Show(instructionData)
	end)
end

function LotteryTipsView1:__Dispose()
	self.templatePool:Dispose(function(item)
		item:Dispose()
	end)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

return LotteryTipsView1
