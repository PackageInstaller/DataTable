-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\RearHouse\\RearHouseDragHero.lua

local RearHouseDragObject = require("Logic/RearHouse/RearHouseDragObject")
local Model = require("Entity/Model")
local ResHeroBase = require("ClientData/ResHeroBase")
local RearHouseModelManager = require("Logic/RearHouse/RearHouseModelManager")
local ModelTool = require("Entity/ModelTool")
local strClassName = "RearHouseDragHero"
local RearHouseDragHero = Class(strClassName, RearHouseDragObject)

function RearHouseDragHero:ctor(parent, putData, initData)
	self.isHighModelLoaded = false
	self.isLowModelLoaded = false
end

function RearHouseDragHero:destroy(...)
	self:_destroyHighModel()

	if self.loadHighTask then
		self.loadHighTask:Stop()
	end

	if self.setLoadTask then
		self.setLoadTask:Stop()
	end

	RearHouseDragHero.super.destroy(self)

	self.isLowModelLoaded = false

	RearHouseModelManager.onLowModelNumChange(-1)
end

function RearHouseDragHero:_destroyHighModel(...)
	if self.entityModelHigh then
		RearHouseModelManager.onHighModelNumChange(-1)
		self.entityModelHigh:destroy()

		self.entityModelHigh = nil
	end

	self.isHighModelLoaded = false
end

function RearHouseDragHero:getHeroModelData(info, high)
	local modelData = {}

	modelData.model_type = Const.MODEL_TYPE.RearHouse
	self.hero = true
	modelData.model_id = self.modelId

	if high then
		modelData.use_lod = Const.MODEL_LOD_LV1
	else
		modelData.use_lod = Const.MODEL_LOD_LV2
	end

	local animator = ModelTool.getAnimator(modelData.model_id, Const.MODEL_TYPE.RearHouse)

	if animator then
		modelData.animator = animator
	end

	return modelData
end

function RearHouseDragHero:_initModel(info)
	self:loadModelOnly(false)

	if RearHouseModelManager.isLimitModelQuality() == false then
		if Const.REARHOUSE_LOAD_CONFIG.DELAY.HERO_HIGH == true then
			self.loadHighTask = Timer.New(function(...)
				self:loadModelOnly(true)
			end, 0.3)

			self.loadHighTask:Start()
		else
			self:loadModelOnly(true)
		end
	end
end

function RearHouseDragHero:onModelLoadedEndHigh(...)
	local go = self.entityModelHigh.modelGameObject

	self.entityModelHigh:setModelLayer(Const.LAYER_NPC)

	self.isHighModelLoaded = true

	RearHouseModelManager.onHighModelNumChange(1)

	if RearHouseModelManager.isLimitModelQuality() then
		self.dragController:SetLodGroup(go, -1)
		self:setModelPos(go, false)
		ModelTool.addBaseModel(self.entityModelHigh:getModelInsId(), self:_getBaseModelId(), 1, Const.HERO_BASE_TYPE.Rear)
	else
		self.dragController:SetLodGroup(go, 0)
		self:setModelPos(go, true)
		self:_checkLoadedEnd(true)
	end

	self:checkLoadHigh()
end

function RearHouseDragHero:onModelLoadedEnd()
	local go = self.entityModel.modelGameObject

	self.entityModel:setModelLayer(Const.LAYER_NPC)

	self.isLowModelLoaded = true

	RearHouseModelManager.onLowModelNumChange(1)

	if self.hero then
		self.dragController:SetLodGroup(go, -1)
		self:setModelPos(go, false)
		ModelTool.addBaseModel(self.entityModel:getModelInsId(), self:_getBaseModelId(), 1, Const.HERO_BASE_TYPE.Rear)
	end

	self:checkLoadHigh()
	self:_checkLoadedEnd(false)
end

function RearHouseDragHero:_getBaseModelId(...)
	if self.putData.hero then
		return self.putData.hero:getShowBaseModelId()
	else
		return self.data.baseId or self.modelId
	end
end

function RearHouseDragHero:_checkLoadedEnd(isHigh)
	self.loadedNum = self.loadedNum + 1

	if self.initData and not isHigh then
		self.mParent:addLoadedNum(self)
	end

	if self.loadedNum == 2 then
		self.setLoadTask = Timer.New(Slot(self.recalculateLodBounds, self), 0.02)

		self.setLoadTask:Start()
	end
end

function RearHouseDragHero:recalculateLodBounds(...)
	self.dragController:RecalculateLodBounds()
end

function RearHouseDragHero:setModelPos(go, needOffset)
	local size = self.mParent.gridSize
	local x, y = self:getConfigOffset()

	self:setRotation(0)

	local baseOffset = 0

	self.modelsOffset = Vector3(0, 0.1, 0)
	go.transform.parent.localPosition = self.modelsOffset

	local baseInfo = ResHeroBase[self.data.modelId]

	if baseInfo and baseInfo[1] then
		local info = baseInfo[1][Const.HERO_BASE_TYPE.Rear]

		if info and info[1] then
			baseOffset = info[1].height or 0
		end
	end

	if needOffset or baseOffset == 0 then
		y = y + baseOffset
	end

	go.transform.localPosition = Vector3(x, y, 0)
end

function RearHouseDragHero:checkLoadHigh(...)
	if RearHouseModelManager.isLimitModelQuality() == false then
		return
	end

	self:checkLowModeShow()
end

function RearHouseDragHero:checkLowModeShow(...)
	local isFarMode = RearHouseModelManager.isFarMode()
	local bounds = RearHouseModelManager.getCurCameraFieldBounds()
	local isIn = self:_isInBounds(bounds)

	if isFarMode or isIn == false then
		if RearHouseModelManager.isMustDestroyHigh() then
			self:_destroyHighModel()
		elseif self.entityModelHigh and self.isHighModelLoaded == true then
			self.entityModelHigh:showModel(false)
		end

		if self.entityModel then
			self.entityModel:showModel(true)
		end
	else
		if self.entityModelHigh == nil then
			self:loadModelOnly(true, true)

			return
		end

		if self.entityModel and self.isLowModelLoaded == true and self.entityModelHigh and self.isHighModelLoaded == true then
			self.entityModel:showModel(false)
			self.entityModelHigh:showModel(true)
		end
	end
end

function RearHouseDragHero:_isInBounds(bounds)
	local r, c = self.mParent:gridIdxToRowColumn(self.gridPos)

	if r > bounds.maxRow then
		return false
	end

	if c > bounds.maxCol then
		return false
	end

	if r + self.boundsInfo.down - 1 < bounds.minRow then
		return false
	end

	if c + self.boundsInfo.right - 1 < bounds.minCol then
		return false
	end

	return true
end

return RearHouseDragHero
