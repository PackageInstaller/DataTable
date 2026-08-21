-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/unit/UnitCompHeroXinMao.lua

module("logic.common.unit.UnitCompHeroXinMao", package.seeall)

local M = class("UnitCompHeroXinMao")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._resLoaderXinMao = MultiResLoader.New()
	self._finishHandler = Handler.New()
end

function M:Awake()
	return
end

function M:OnDestroy()
	self:setEvent(false)
	self:clear()

	self._resLoaderXinMao = nil
	self._finishHandler = nil
end

function M:getIsLoadedFinish()
	return self._isAllFinish
end

function M:getXinMaoInst()
	if self._resInstXinMao and self._xinMaoPath and self._resInstXinMao[self._xinMaoPath] then
		return self._resInstXinMao[self._xinMaoPath]
	end

	return nil
end

function M:getResInst(path)
	if self._resInstXinMao then
		return self._resInstXinMao[path]
	end

	return nil
end

function M:clear()
	self._isAllFinish = false

	for path, go in pairs(self._resInstXinMao or {}) do
		if go and not goutil.isNil(go) then
			goutil.destroy(go.gameObject)
		end
	end

	self._resInstXinMao = nil

	if self._resDicXinMao then
		for _, res in pairs(self._resDicXinMao) do
			res:Release()
		end
	end

	self._resDicXinMao = nil

	if self._resLoaderXinMao then
		self._resLoaderXinMao:clear()
	end

	self._xinMaoPath = nil
	self._xinMaoBindGo = nil

	if self._finishHandler then
		self._finishHandler:clear()
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_STATE_PREVIEW, self._handleAirtightStatePreview, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_STATE_PREVIEW, self._handleAirtightStatePreview, self)
	end
end

function M:_handleAirtightStatePreview(_, isInAirtight)
	self:_updateAirtightTimeState()
end

function M:_handleAritightStateChange(e, isInAirtightTime, airtightEndTS)
	self:_updateAirtightTimeState()
end

function M:_updateAirtightTimeState()
	if self._judgeAirtightTime or self._judgeAirtightPreviewState then
		local show = AirtightRoomController.instance:getIsInAirtightTime(nil, nil, nil, false)

		self:setXinMaoShow(show)
	end
end

function M:setJudgeAirtightTime(judgeAirtightTime)
	self._judgeAirtightTime = judgeAirtightTime

	if self._judgeAirtightTime then
		self:_updateAirtightTimeState()
	else
		self:setXinMaoShow(true)
	end
end

function M:setJudgeAirtightPreviewState(judgeState)
	self._judgeAirtightPreviewState = judgeState

	if self._judgeAirtightPreviewState then
		self:_updateAirtightTimeState()
	else
		self:setXinMaoShow(true)
	end
end

function M:setDefaultHide(defaultHide)
	self._defaultHide = defaultHide
end

function M:refreshXinMaoShow()
	if self._defaultHide then
		self:setXinMaoShow(false)
	elseif self._judgeAirtightTime or self._judgeAirtightPreviewState then
		self:_updateAirtightTimeState()
	else
		self:setXinMaoShow(true)
	end
end

function M:setXinMaoShow(show)
	local xinMao = self:getXinMaoInst()

	if xinMao and not goutil.isNil(xinMao) then
		goutil.setActive(xinMao.gameObject, show)
	end
end

function M:updateXinMaoLightShow()
	local xinMao = self:getXinMaoInst()

	if not xinMao or goutil.isNil(xinMao) then
		return
	end

	local xinMaoLightGo = CharacterUtil.getXinMaoLightGo(xinMao)

	if not xinMaoLightGo or goutil.isNil(xinMaoLightGo) then
		return
	end

	local config = GfxModel.instance:getCurGfx()
	local show = false

	if config then
		show = config.xinmaoLight
	end

	goutil.setActive(xinMaoLightGo.gameObject, show)
end

function M:setInfo(modelId, animationPlayer, callBack, callBackHandler)
	self:clear()

	if not modelId then
		return
	end

	if not animationPlayer or goutil.isNil(animationPlayer) then
		return
	end

	local xinMaoBindGo = CharacterUtil.getXinMaoMount(animationPlayer.gameObject)

	if not xinMaoBindGo then
		if Astral.OSDef.isEditor then
			printWarn(string.format("模型[%s]没有xinmao绑点", modelId))
		end

		return
	end

	local modelData = ModelConfig.instance:getModelData(modelId)

	if not modelData then
		return
	end

	local pathXinMao = modelData:getXinMaoPath()

	if not pathXinMao then
		return
	end

	self._finishHandler:setListener(callBack, callBackHandler)

	self._xinMaoBindGo = xinMaoBindGo
	self._xinMaoPath = pathXinMao

	self:setEvent(true)
	self._resLoaderXinMao:setResPaths({
		self._xinMaoPath
	})
	self._resLoaderXinMao:load(self._onAllResLoadedXinMao, self._onResLoadedXinMao, self)
end

function M:_onAllResLoadedXinMao(loader)
	self._isAllFinish = true

	if self._defaultHide then
		self:setXinMaoShow(false)
	elseif self._judgeAirtightTime or self._judgeAirtightPreviewState then
		self:_updateAirtightTimeState()
	else
		self:setXinMaoShow(true)
	end

	self:updateXinMaoLightShow()

	if self._finishHandler and self._finishHandler:hadCallback() then
		self._finishHandler:call(self:getXinMaoInst())
	end
end

function M:_onResLoadedXinMao(res)
	if not res.IsSuccess then
		printError(string.format("资源加载失败:%s", res.ResPath))

		return
	end

	local xinMaoBindGo = self._xinMaoBindGo

	if not xinMaoBindGo or goutil.isNil(xinMaoBindGo) then
		return
	end

	local prefabAsset = res:GetAsset(nil, nil)
	local prefabInst = goutil.cloneAndSetParent(prefabAsset, xinMaoBindGo.transform)

	goutil.setActive(prefabInst.gameObject, false)

	local prefabTr = prefabInst.transform

	Astral.TransformUtil.SetLocalPos(prefabTr, 0, 0, 0)
	Astral.TransformUtil.SetLocalRotation(prefabTr, 0, 0, 0)

	if not self._resDicXinMao then
		self._resDicXinMao = {}
	end

	self._resDicXinMao[res.ResPath] = res

	res:Retain()

	if not self._resInstXinMao then
		self._resInstXinMao = {}
	end

	self._resInstXinMao[res.ResPath] = prefabInst
end

return M
