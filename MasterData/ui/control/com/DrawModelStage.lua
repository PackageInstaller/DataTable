-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\DrawModelStage.lua

local DrawCardConfig = require("DesignerScript/DrawCardConfig")
local ModelStage = require("UI/Control/Com/ModelStage")
local UIUtils = require("Framework.UI.UIUtils")
local CustomShadowManager = require("System/CustomShadowManager")
local UIDrawCardShowType = typeof(Framework.UI.UIDrawCardShow)
local DrawModelStage = Class("DrawModelStage", ModelStage)

function DrawModelStage:ctor(prefabPath, callback)
	self.prefabPath = prefabPath
	self._models = {}
	self._modelsActive = {}
	self._modelsVisible = {}
	self._modelInsIds = {}
	self.loadedCallback = callback
end

function DrawModelStage:startLoad(pos)
	UIUtils.CreateModelStage(self.prefabPath, pos, self, 1)
end

function DrawModelStage:OnCtorEnd(id, obj)
	self.id = id
	self._obj = obj

	self:_onLoadedCustomShadow()
	self:_initShowComponent()

	if self.loadedCallback then
		self.loadedCallback(self)
	end
end

function DrawModelStage:initSlideOperation(control, step, slideCallback)
	if self._obj then
		self._obj:InitDrawModelStage(control:getGameObject(), step or 0.1, slideCallback)
	end
end

function DrawModelStage:setOperateModel(boxId, loadedCallback)
	if self._obj then
		self._obj:PrepareOperation(boxId, loadedCallback)
	end
end

function DrawModelStage:playIn(...)
	if self._obj then
		self._obj:PlayTimeLine(0)
	end
end

function DrawModelStage:playResult(...)
	if self._obj then
		self._obj:PlayTimeLine(1)
	end
end

function DrawModelStage:directPlayInEnd()
	if self._obj then
		self._obj:ResetTimeLine(0, DrawCardConfig.FIRST_TIMELINE_OFFSET)
	end
end

function DrawModelStage:directPlayOpened()
	if self._obj then
		self._obj:ResetTimeLine(1, DrawCardConfig.SECOND_TIMELINE_OFFSET)
	end
end

function DrawModelStage:setEffectColor(maxStarLv, starCount)
	local mainColorIndex = DrawCardConfig.STAR_COLOR_INDEX[maxStarLv] or 0

	if self._obj then
		self._obj:SetFlyEffectColor(mainColorIndex)
	end
end

function DrawModelStage:setFlyEffectActive(flyEffNums)
	if self._obj then
		for index, num in ipairs(flyEffNums) do
			self._obj:ActiveFlyEff(index, num)
		end
	end
end

function DrawModelStage:setOpenAudioPath(maxStarLv)
	if self._obj then
		local audioIndex = DrawCardConfig.OPEN_AUDIO_INDEX[maxStarLv] or 0

		self._obj:SetOpenAudioPath(audioIndex)
	end
end

function DrawModelStage:setLittleCells(cellIdxList)
	local listStr = ""
	local listCount = #cellIdxList

	if listCount == 1 then
		listStr = tostring(cellIdxList[1])
	elseif listCount == 10 then
		listStr = string.format("%d%d%d%d%d%d%d%d%d%d", cellIdxList[1], cellIdxList[2], cellIdxList[3], cellIdxList[4], cellIdxList[5], cellIdxList[6], cellIdxList[7], cellIdxList[8], cellIdxList[9], cellIdxList[10])
	else
		return
	end

	if self._obj then
		self._obj:PrepareCells(listStr)
	end
end

function DrawModelStage:setBoxShadow(isSmall)
	self.boxGo = self:getBoxGO(isSmall)

	CustomShadowManager.registerModelStageGameObject(self.boxGo, true)
end

function DrawModelStage:_activeCustomShadow(active)
	DrawModelStage.super._activeCustomShadow(self, active)

	if self.boxGo then
		CustomShadowManager.registerModelStageGameObject(self.boxGo, active)
	end
end

function DrawModelStage:getBoxGO(isSmall)
	if self._obj then
		return self._obj:GetBoxGO(not isSmall)
	end
end

function DrawModelStage:_initShowComponent(...)
	if self._obj then
		self._showComponent = self._obj.gameObject:GetComponent(UIDrawCardShowType)
	end
end

function DrawModelStage:showQualityLogo(star)
	if self._showComponent then
		self._showComponent:ShowQualityLogo(star - 3)
	end
end

function DrawModelStage:clearQualityLogo()
	if self._showComponent then
		self._showComponent:ShowQualityLogo(-1)
	end
end

return DrawModelStage
