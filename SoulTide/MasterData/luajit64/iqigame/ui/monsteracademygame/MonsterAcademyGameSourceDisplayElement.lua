-- chunkname: @IQIGame\\UI\\MonsterAcademyGame\\MonsterAcademyGameSourceDisplayElement.lua

local m = {
	imagePath = ""
}

function m.New(viewRoot)
	local obj = Clone(m)

	obj:__Init(viewRoot)

	return obj
end

function m:__Init(viewRoot)
	self.ViewRoot = viewRoot

	LuaCodeInterface.BindOutlet(self.ViewRoot, self)

	self.imagePath = UIGlobalApi.GetImagePath("/Activity/MonsterAcademy/Batch1/MonsterAcademyGameUI/MACGameCommon/")
	self.bitsImage = self.bitsRoot.gameObject:GetComponent("UnityEngine.UI.Image")
	self.tenImage = self.tenRoot.gameObject:GetComponent("UnityEngine.UI.Image")
	self.symbolImage = self.symbolRoot.gameObject:GetComponent("UnityEngine.UI.Image")
end

function m:OnShowScore(score, position)
	local tenNum, bitsNum = math.modf(math.abs(score) / 10)

	self:__FillScoreImage(score > 0, bitsNum * 10, tenNum)
	self:__DoShow(position)
end

function m:__FillScoreImage(idAdd, bitsNum, tenNum)
	local symbolImgName = idAdd and "MonsterAcademy_Fruit_Add" or "MonsterAcademy_Fruit_Subtract"

	AssetUtil.LoadImage(self, self.imagePath .. symbolImgName .. ".png", self.symbolImage)

	if tenNum == 0 then
		self.tenRoot.gameObject:SetActive(false)
	else
		AssetUtil.LoadImage(self, self.imagePath .. symbolImgName .. "_" .. tostring(tenNum) .. ".png", self.tenImage)
		self.tenRoot.gameObject:SetActive(true)
	end

	AssetUtil.LoadImage(self, self.imagePath .. symbolImgName .. "_" .. tostring(bitsNum) .. ".png", self.bitsImage)
end

function m:__DoShow(position)
	self.ViewRoot.transform.position = position
	self.ViewRoot.transform.localScale = Vector3.one

	self.ViewRoot.gameObject:SetActive(true)
	Timer.New(function()
		LuaCodeInterface.TweenScale(self.ViewRoot.gameObject, 0.15, Vector3.one, Vector3.zero, function(go)
			self.ViewRoot.gameObject:SetActive(false)
		end)
	end, 1):Start()
end

function m:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.ViewRoot, self)
	self.ViewRoot.gameObject:SetActive(false)
	UnityEngine.Object.Destroy(self.ViewRoot.gameObject)

	self.ViewRoot = nil
end

return m
