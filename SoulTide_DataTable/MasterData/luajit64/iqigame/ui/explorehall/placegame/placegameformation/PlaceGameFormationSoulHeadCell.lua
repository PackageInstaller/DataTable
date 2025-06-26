-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameFormation\\PlaceGameFormationSoulHeadCell.lua

local m = {}
local PlaceGameSoulHeadCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGamePlayerRecruit.PlaceGameSoulHeadCell")

function m.New(view, isNotMySoul)
	local obj = Clone(m)

	obj:Init(view, isNotMySoul)

	return obj
end

function m:Init(view, isNotMySoul)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.placeGameSoulHeadCell = PlaceGameSoulHeadCell.New(self.SoulHeadView)

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(soulData)
	self.placeGameSoulData = soulData

	self.placeGameSoulHeadCell.View:SetActive(soulData ~= nil)

	if soulData == nil then
		return
	end

	self.placeGameSoulHeadCell:SetData(soulData)
end

function m:ShowTag(top, str)
	if self.Tag then
		self.Tag:SetActive(top)
	end

	if self.TagText and str then
		UGUIUtil.SetText(self.TagText, str)
	end
end

function m:ShowFrameBG(showImgFrame, showImgBg)
	if self.ImgFrame then
		self.ImgFrame:SetActive(showImgFrame)
	end

	if self.ImgBg then
		self.ImgBg:SetActive(showImgBg)
	end
end

function m:Dispose()
	self.placeGameSoulHeadCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
