local UILandlady = {}
local this = UILandlady

local prefabPath = "UI/Prefabs/View/Items/UILandlady.prefab"

-- 看板娘
function this.__init(self, root, configId, linesRoot)
	self.root = root
	self.linesRoot = linesRoot
	
	self.configId = configId
	self.sounds = loadtable(Z_CardSoundExtend[self.configId].Sound)
	self.faces = loadtable(Z_CardSoundExtend[self.configId].Face)
	
	self.prefab = nil
	self.faceTnf = nil
	self.rand = nil
	self.isPlaying = false
	self.onCompleted = {}
	self.playId = 1
end

function this.GetPlayId(self)
	self.playId = self.playId + 1
	return self.playId
end

-- 加载立绘
function this.LoadDrawing(self)
	self.prefab = self.prefab or GameObjectPool:GetInstance():CoGetGameObjectAsync(prefabPath)
	self.prefab.transform:SetParent(self.root.transform, false)
	self.prefab.transform:DOLocalMove(Vector3.New(0, 0, 0), 0)
	self.prefab.transform:DOScale(Vector3.New(1, 1, 1), 0)
	local img = self.prefab.transform:Find("Drawing"):GetComponent("Image")
	local cardId = Z_CardSoundExtend[self.configId].CardId
	local stage = Z_CardSoundExtend[self.configId].Stage
	local path = "UI/CardPaint/"..cardId.."_"..stage
	-- 和谐
	local skin = table.first(Z_Skin, function (v) return v.BelongCard == cardId and v.Stage == stage end)
	if skin ~= nil then
		path = "UI/CardPaint"..skin.CardPaint.."/"..cardId.."_"..stage
	end
	img.gameObject:SetActive(true)
	img.enabled = false
	img.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path..".png")
	img.enabled = true
	img:DOFade(1, 0)
	img:SetNativeSize()
end

-- 加载表情
function this.LoadFace(self, faceId)
	local faceParent = self.prefab.transform:Find("Face")
	for i = 0, faceParent.childCount - 1 do
		local tnf = faceParent:GetChild(i)
		if tnf.name == Z_CardSoundExtend[self.configId].CardId.."_"..Z_CardSoundExtend[self.configId].Stage then
			self.faceTnf = tnf
		else
			tnf.gameObject:SetActive(false)
		end
	end
	if IsNull(self.faceTnf) then
		Logger.Log("error:" .. Z_CardSoundExtend[self.configId].CardId.."_"..Z_CardSoundExtend[self.configId].Stage.." is null")
		return
	end
	self.faceTnf.gameObject:SetActive(false)
	local faceImg = AtlasManager:GetInstance():CoLoadImageAsync("UI/CardPaintFace/"..Z_CardSoundExtend[self.configId].CardId.."_"..Z_CardSoundExtend[self.configId].Stage.."_"..faceId..".png")
	if faceImg == nil then
		return
	end
	local img = self.faceTnf:GetComponent("Image")
	img.sprite = faceImg
	img:DOFade(1, 0)
	self.faceTnf.gameObject:SetActive(true)
end

-- 随机表情和语音
function this.Random(self)
	if table.count(self.sounds) ~= table.count(self.faces) then
		Logger.Log("sounds ~= faces")
	end
	if table.count(self.sounds) ~= 0 then
		self.rand = math.random(1, math.min(table.count(self.sounds), table.count(self.faces)))
	else
		self.rand = math.random(1, table.count(self.faces))
	end
end

-- 回调
function this.BindCallback(self, playId, callback)
	if self.onCompleted[playId] == nil then
		self.onCompleted[playId] = {}
	end
	table.insert(self.onCompleted[playId], callback)
end

-- 播放音效
function this.PlaySound(self)
	if self.isPlaying then
		return
	end
	self.isPlaying = true
	local cardId = Z_CardSoundExtend[self.configId].CardId
	local soundType = Z_CardSoundExtend[self.configId].SoundType
	local soundName = self.sounds[self.rand]
	if soundName == nil then
		return
	end
	local soundPath = "Sound/"..cardId.."/"..soundType.."/"..soundName..".mp3"
	-- 据声音类型   角色id  声音名字 找台词
	if self.linesRoot then
		local zLines = table.first(Z_Lines, function (v) return v.BelongCard == cardId and v.SoundType == soundType and v.SoundName == soundName end)
		self.linesRoot.gameObject:SetActive(zLines ~= nil)
		if zLines then
			LangUtil.BindText(self.linesRoot.transform:Find("Text")).text = zLines.Lines
		end
	end
	local playId = self.playId
	local asset = ResourcesManager:GetInstance():CoLoadAsync(soundPath, typeof(AudioClip))
	Game.Scene:GetComponent("SoundComponent"):CoCardPlay(soundPath)
	local time = 0
	coroutine.start(function ()
		coroutine.waituntil(function ()
			local length = 0
			if asset ~= nil then
			   length = asset.length
			end
			time = time + Time.deltaTime
			return not self.isPlaying or time > asset.length
		end)
		if self.onCompleted[playId] and table.count(self.onCompleted[playId]) then
			table.walk(self.onCompleted[playId], function (k, callback)
				callback()
			end)
		end
	end)
end

-- API:播放表情和语音
function this.CoPlay(self, configId)
	if configId ~= nil then
		self.configId = configId
	end
	if self.root == nil or self.configId == nil then
		Logger.LogError("img or configId is nil")
		return
	end
	self.sounds = loadtable(Z_CardSoundExtend[self.configId].Sound)
	self.faces = loadtable(Z_CardSoundExtend[self.configId].Face)
	self.isPlaying = false
	self.onCompleted = {}
	self:BindCallback(self:GetPlayId(), function()
		if not IsNull(self.faceTnf) then
			self.faceTnf.gameObject:SetActive(false)
		end
		self.isPlaying = false
		self.rand = nil
		if self.linesRoot then
			self.linesRoot.gameObject:SetActive(false)
		end
	end)
	self:LoadDrawing()
	self:Random()
	coroutine.start(function () self:LoadFace(self.faces[self.rand]) end)
	coroutine.start(function () self:PlaySound() end)
end

function this.CoPlaySound(self, configId)
	if configId ~= nil then
		self.configId = configId
	end
	if self.configId == nil then
		Logger.LogError("img or configId is nil")
		return
	end
	self.sounds = loadtable(Z_CardSoundExtend[self.configId].Sound)
	self.faces = loadtable(Z_CardSoundExtend[self.configId].Face)
	self.isPlaying = false
	self.onCompleted = {}
	self:BindCallback(self:GetPlayId(), function()
		self.isPlaying = false
		self.rand = nil
		if self.linesRoot then
			self.linesRoot.gameObject:SetActive(false)
		end
	end)
	self:Random()
	self:PlaySound()
end

-- API:表情依赖
function this.BindPlay(self, uiLandlady)
	if self.root == nil or self.configId == nil then
		Logger.LogError("img or configId is nil")
		return
	end
	if self.configId ~= uiLandlady.configId then
		Logger.LogError("cannot bind")
		return
	end
	uiLandlady:BindCallback(uiLandlady.playId, function()
		if not IsNull(self.faceTnf) then 
			self.faceTnf.gameObject:SetActive(false)
		end
		self.isPlaying = false
		self.rand = nil
		if self.linesRoot then
			self.linesRoot.gameObject:SetActive(false)
		end
	end)
	self:LoadDrawing()
	self.rand = uiLandlady.rand
	if self.rand == nil then
		if not IsNull(self.faceTnf) then
			self.faceTnf.gameObject:SetActive(false)
		end
		return
	end
	if self.linesRoot and uiLandlady.linesRoot then
		self.linesRoot.gameObject:SetActive(uiLandlady.linesRoot.gameObject.activeSelf)
		LangUtil.BindText(self.linesRoot.transform:Find("Text")).text = uiLandlady.linesRoot.transform:Find("Text"):GetComponent("Text").text
	end
	self:LoadFace(self.faces[self.rand])
end

-- 停止
function this.Stop(self)
	Game.Scene:GetComponent("SoundComponent"):Stop()
	self.isPlaying = false
end

-- 关闭
function this.Disable(self)
	self:BindDisable()
	Game.Scene:GetComponent("SoundComponent"):Stop()
end

function this.BindDisable(self)
	if not IsNull(self.prefab) then
		local faceParent = self.prefab.transform:Find("Face")
		for i = 0, faceParent.childCount - 1 do
			faceParent:GetChild(i).gameObject:SetActive(false)
		end
		local drawing = self.prefab.transform:Find("Drawing")
		for i = 0, drawing.childCount - 1 do
			drawing:GetChild(i).gameObject:SetActive(false)
		end
		if self.linesRoot then
			self.linesRoot.gameObject:SetActive(false)
		end
		GameObjectPool:GetInstance():RecycleGameObject(prefabPath, self.prefab)
		self.prefab = nil
	end
	self.faceTnf = nil
	self.rand = nil
	self.isPlaying = false
	self.onCompleted = {}
end

return DataClass("UILandlady", this)