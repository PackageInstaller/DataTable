-- chunkname: @IQIGame\\UI\\Battle\\BattleUICutinView.lua

local ImageCache = {
	isReady = false
}

function ImageCache.New()
	local obj = Clone(ImageCache)

	obj.imagePath = ""
	obj.isReady = false

	return obj
end

local m = {
	isPlaying = false,
	isComplete = false,
	cutInCache = ImageCache.New(),
	elementImgBGCache = ImageCache.New(),
	elementImgBigCache = ImageCache.New(),
	elementImgSmallCache = ImageCache.New(),
	elementImgWordCache = ImageCache.New()
}

function m.New(view)
	local obj = Clone(m)

	obj:__Init(view)

	return obj
end

function m:__Init(view)
	self.gameObject = view
	self.isPlaying = false
	self.isComplete = false

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.animCom = self.gameObject:GetComponent("Animation")

	self.gameObject:SetActive(false)
end

function m:Show(battleUnitID, skillCid, callback)
	self.callbackEvent = callback

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)
	local path = BattleModule.GetBattleUnitSkinImageByUnitData(battleUnitData, Constant.SkinImageType.HeroResourcesVerticalDraw)

	if LuaUtility.StrIsNullOrEmpty(path) then
		self.gameObject:SetActive(false)
		self.callbackEvent()

		return
	end

	self.gameObject:SetActive(true)

	self.isPlaying = false
	self.isComplete = false
	self.cutInCache.isReady = false
	self.elementImgBGCache.isReady = false
	self.elementImgBigCache.isReady = false
	self.elementImgSmallCache.isReady = false
	self.elementImgWordCache.isReady = false

	local skillConfig = CfgSkillTable[skillCid]

	self.ultimateText:GetComponent("Text").text = skillConfig.Name

	self:__LoadImage(path, self.cutInCache, self.cutinImg.gameObject:GetComponent("Image"), true)

	local elementType = battleUnitData.skillsData[skillCid].elementType
	local bgImagePath = BattleUIApi:GetCutinElementImgBG(elementType)

	self:__LoadImage(bgImagePath, self.elementImgBGCache, self.elementImgBG.gameObject:GetComponent("Image"))

	local bigPath = BattleUIApi:GetCutinElementImgBig(elementType)

	self:__LoadImage(bigPath, self.elementImgBigCache, self.elementImgBig.gameObject:GetComponent("Image"))

	local smallPath = BattleUIApi:GetCutinElementImgSmall(elementType)

	self:__LoadImage(smallPath, self.elementImgSmallCache, self.elementImgSmall.gameObject:GetComponent("Image"))

	local wordPath = BattleUIApi:GetCutinElementImgWord(elementType)

	self:__LoadImage(wordPath, self.elementImgWordCache, self.elementImgWord.gameObject:GetComponent("Image"))

	self.isPrepareShow = true
end

function m:__LoadImage(path, cacheData, imgCom, resetPivot)
	local function successCall(_cacheData)
		_cacheData.isReady = true
	end

	imgCom.gameObject:SetActive(true)

	if LuaUtility.StrIsNullOrEmpty(path) then
		imgCom.gameObject:SetActive(false)
		successCall(cacheData)

		return
	end

	if cacheData.imagePath == path then
		successCall(cacheData)

		return
	end

	cacheData.imagePath = path
	cacheData.isReady = false

	AssetUtil.LoadImage(self, path, imgCom, function()
		imgCom:SetNativeSize()

		if resetPivot then
			LuaUtility.SetImageRectTransformPivot(imgCom.rectTransform, imgCom)
		end

		successCall(cacheData)
	end, function()
		imgCom.gameObject:SetActive(false)
		successCall(cacheData)
	end)
end

function m:__CheckAllReady()
	if not self.isPrepareShow then
		return
	end

	if not self.cutInCache.isReady then
		return
	end

	if not self.elementImgBGCache.isReady then
		return
	end

	if not self.elementImgBigCache.isReady then
		return
	end

	if not self.elementImgSmallCache.isReady then
		return
	end

	if not self.elementImgWordCache.isReady then
		return
	end

	self.isPrepareShow = false

	self:__PlayAnima()
end

function m:__PlayAnima()
	self.animCom:Play(BattleUIApi:GetCutinEffectAnimName())

	self.isPlaying = true
end

function m:OnUpdate()
	if self.isPrepareShow then
		self:__CheckAllReady()
	end

	if not self.isPlaying then
		return
	end

	if self.animCom.isPlaying then
		return
	end

	if self.isComplete then
		return
	end

	if self.callbackEvent ~= nil then
		self.callbackEvent()
	end

	self:Hide()
end

function m:Hide()
	self.isPlaying = false
	self.isComplete = false

	self.gameObject:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return m
