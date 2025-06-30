-- chunkname: @IQIGame\\UI\\MonsterAcademyGame\\JigsawGameBlockItem.lua

local m = {
	BlockRow = 0,
	unitU = 0,
	unitV = 0,
	BlockCol = 0,
	IsEmpty = false,
	LogicCol = 0,
	LogicRow = 0
}

function m.New(viewRoot, row, col)
	local obj = Clone(m)

	obj:__Init(viewRoot, row, col)

	return obj
end

function m:__Init(viewRoot, row, col)
	self.Root = viewRoot
	self.LogicRow = row
	self.LogicCol = col

	LuaCodeInterface.BindOutlet(self.Root, self)
	self.goSelect.gameObject:SetActive(false)

	self.rawImg = self.Icon:GetComponent("UnityEngine.UI.RawImage")

	function self.__OnBlockClickedEventProxy()
		if self.IsEmpty then
			return
		end

		self:__OnBlockClickedEventHandler()
	end

	self.Root:GetComponent("Button").onClick:AddListener(self.__OnBlockClickedEventProxy)
end

function m:__OnBlockClickedEventHandler()
	self:BlockClickEvent()
end

function m:SetData(texture, row, unit_u, col, unit_v)
	self.rawImg.texture = texture
	self.unitU = unit_u
	self.unitV = unit_v

	self.goSelect.gameObject:SetActive(false)
	self:UpdateUVData(row, col)
	self:ShowIcon()
end

function m:UpdateUVData(row, col)
	self.BlockRow = row
	self.BlockCol = col
	self.rawImg.uvRect = UnityEngine.Rect(row * self.unitU, col * self.unitV, self.unitU, self.unitV)
end

function m:ShowIcon()
	self.IsEmpty = false

	self.Icon.gameObject:SetActive(true)
	self.EmptyIcon.gameObject:SetActive(false)
end

function m:ShowEmpty()
	self.IsEmpty = true

	self.Icon.gameObject:SetActive(false)
	self.EmptyIcon.gameObject:SetActive(true)
end

function m:SetSelect(active)
	self.goSelect.gameObject:SetActive(active)
end

function m:IsPositionCorrect()
	return self.LogicCol == self.BlockCol and self.LogicRow == self.BlockRow
end

function m:OnDestroy()
	self.Root:GetComponent("Button").onClick:RemoveListener(self.__OnBlockClickedEventProxy)
	LuaCodeInterface.ClearOutlet(self.Root, self)
	UnityEngine.GameObject.Destroy(self.Root.gameObject)

	self.Root = nil
end

return m
