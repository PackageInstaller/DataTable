-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spriteladder/view/ItemLadderReward.lua

module("logic.extensions.spriteladder.view.ItemLadderReward", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local ItemLadderReward = class("ItemLadderReward")

ItemLadderReward.Events = {}
ItemLadderReward.Events.onClick = "ItemLadderReward.Events.onClick"

function ItemLadderReward:ctor(target)
	NotifyDispatcher.extend(self)

	self._target = target.gameObject
	self._data = {}
	self._imgCurHeadIcon = goutil.findChild(self._target, "Nego_Info/imgCurHeadIcon"):GetComponent("Image")
	self._hasGeted = goutil.findChild(self._target, "Nego_Info/hasGeted")
	self._onClickHandler = PointerClickHandler.Get(self._target):AddLuaHandler(function(go, eventData)
		if eventData.dragging then
			return
		end

		self:_onClick()
	end)
	self._lock = goutil.findChild(self._target, "Nego_Info/lock")
	self._lockTxt = goutil.findChild(self._target, "Nego_Info/lock/Text"):GetComponent(goutil.Type_UIText)
end

function ItemLadderReward.AddOnce(go)
	local component = ItemLadderReward.Get(go)

	component = component or LuaComponentContainer.Add(go, ItemLadderReward)

	return component
end

function ItemLadderReward.Remove(go)
	LuaComponentContainer.Remove(go, ItemLadderReward)
end

function ItemLadderReward.Get(go)
	return (LuaComponentContainer.Get(go, ItemLadderReward))
end

function ItemLadderReward:_onClick()
	self.dispatch(self, ItemLadderReward.Events.onClick, self)
end

function ItemLadderReward:Init(data)
	local img = Framework.ImageBigBG.Get(self._hasGeted)
	local imgPath = "ui/views/spriteladderview/wzjljt_yihuode.png"

	img:SetImage(langpath(imgPath), nil)

	self._data = data

	if data.petId == -1 then
		self._imgCurHeadIcon.gameObject:SetActive(false)
		self._hasGeted.gameObject:SetActive(false)
		self._lock.gameObject:SetActive(false)

		return
	end

	local raceId = 0
	local isSilhouette = data.petId < 0

	raceId = Mathf.Abs(data.petId)
	self.isEnough, self.moFangLevel, self.challengeName = self:_isEnoughMofangLv(raceId)

	local isShowLock = not self.isEnough

	self._lock.gameObject:SetActive(isShowLock)

	if isShowLock then
		self._lockTxt.text = string.format("%d阶开启", self.moFangLevel)
	end

	self._hasGeted.gameObject:SetActive(data.isHasGet)
	self._imgCurHeadIcon.gameObject:SetActive(true)

	self._imgCurHeadIcon.color = isSilhouette and UnityEngine.Color.New(0.29411764705882354, 0.29411764705882354, 0.29411764705882354) or UnityEngine.Color.white

	local petCfg = CharacterConfig.instance:getPetCo(raceId)

	if petCfg then
		local modelCfg = CharacterConfig.instance:getModelCo(checknumber(petCfg.faceIds))

		if modelCfg then
			uGuiUtil.setSpriteToImage(self._imgCurHeadIcon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCfg.headName))
		end
	end
end

function ItemLadderReward:_isEnoughMofangLv(raceId)
	local isEnough, moFangLevel, challengeName
	local cfg = ChallengeConfig.instance:getChallengeCfgByRaceId(raceId)

	if cfg then
		local challengeId = cfg.id

		isEnough, moFangLevel, challengeName = ChallengeController.instance:isMoFangLvEnough(challengeId)
	else
		printInfo("raceId = ", raceId)

		challengeName = "非挑战暂时不做限制"
		moFangLevel = 1
		isEnough = true
	end

	return isEnough, moFangLevel, challengeName
end

function ItemLadderReward:onExit()
	local img = Framework.ImageBigBG.Get(self._hasGeted)

	img:ClearImage()

	img = nil
end

return ItemLadderReward
