-- chunkname: @IQIGame\\UI\\Common\\LinkTipCell\\LinkTipCell.lua

LinkTipCell = {
	cellItemPool = {}
}

local LineTipCellItem = require("IQIGame.UI.Common.LinkTipCell.LinkTipCellItem")

function LinkTipCell.New(view)
	local obj = Clone(LinkTipCell)

	obj:Init(view)

	return obj
end

function LinkTipCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function LinkTipCell:Open(text, refGo, refSide, followerSide)
	local ids = {}
	local idDic = {}

	for findRet in string.gmatch(text, Constant.KeywordTag) do
		if findRet ~= nil then
			local id = string.gsub(string.gsub(findRet, ">.+>", ""), "<keyword=", "")

			if idDic[id] == nil then
				ids[#ids + 1] = tonumber(id)
			end

			idDic[id] = id
		end
	end

	self.View:SetActive(#ids ~= 0)

	if #ids == 0 then
		return
	end

	self:RefreshItems(ids)

	if refGo then
		local followerTrans = self.View.transform:Find("Panel_Tip")

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(followerTrans)

		if followerSide == nil then
			followerSide = UGUISide.TopRight
		end

		if refSide == nil then
			refSide = UGUISide.TopLeft
		end

		local uiCanvas = self.View:GetComponentInParent(typeof(UIController)):GetComponent("Canvas")
		local refTrans = refGo.transform

		UIUtil.AdjustUIInScreen(uiCanvas, refTrans, followerTrans, Vector2.zero, refSide, followerSide)
	end
end

function LinkTipCell:Close()
	self.View:SetActive(false)
end

function LinkTipCell:OnDestroy()
	for i, v in pairs(self.cellItemPool) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function LinkTipCell:RefreshItems(ids)
	for i, v in ipairs(self.cellItemPool) do
		v:SetActive(i <= #ids)
	end

	for i, v in ipairs(ids) do
		local item = self:GetItem(i)

		item:Refresh(v)
	end
end

function LinkTipCell:GetItem(index)
	local descCell = self.cellItemPool[index]

	if descCell == nil then
		local go

		if index == 1 then
			go = self.goCell
		else
			go = UnityEngine.Object.Instantiate(self.goCell)
		end

		go.transform:SetParent(self.goCell.transform.parent, false)

		descCell = LineTipCellItem.New(go)
		self.cellItemPool[index] = descCell
	end

	return descCell
end
