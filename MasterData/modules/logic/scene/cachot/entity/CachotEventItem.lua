-- chunkname: @modules/logic/scene/cachot/entity/CachotEventItem.lua

module("modules.logic.scene.cachot.entity.CachotEventItem", package.seeall)

local CachotEventItem = class("CachotEventItem", LuaCompBase)
local ClickEffectPath = "effects/prefabs_cachot/v1a6_huanghuijiaohu.prefab"

function CachotEventItem:init(go)
	self.go = go
	self.go:GetComponent("Canvas").worldCamera = CameraMgr.instance:getMainCamera()
	self._click = ZProj.BoxColliderClickListener.Get(go)
	self._bigIcon = gohelper.findChildSingleImage(go, "event/#simage_event")
	self._smallIcon = gohelper.findChildImage(go, "event/#simage_icon")
	self._txtName = gohelper.findChildTextMesh(go, "event/#txt_name")
	self._gobattle = gohelper.findChild(go, "tips/#go_battle")
	self._gocostheartnum = gohelper.findChild(go, "tips/#go_normal")
	self._txtcostheartnum = gohelper.findChildTextMesh(go, "tips/#go_normal/#txt_num")
	self._clickEffect = gohelper.findChild(go, "event/#effect")

	if self._clickEffect then
		self._clickEffectLoader = PrefabInstantiate.Create(self._clickEffect)

		self._clickEffectLoader:startLoad(ClickEffectPath, self._onEffectLoaded, self)
	end

	self._goFrameNormal = gohelper.findChild(go, "event/light/frame")
	self._goFrameElite = gohelper.findChild(go, "event/light/frame_orange")
	self._goFrameBoss = gohelper.findChild(go, "event/light/frame_red")
	self._anim = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._anim.keepAnimatorStateOnDisable = true
end

function CachotEventItem:addEventListeners()
	self._click:AddClickListener(self._clickThis, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.NearEventMoChange, self._onNearEventChange, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.BeginTriggerEvent, self._playClickAnim, self)
end

function CachotEventItem:removeEventListeners()
	self._click:RemoveClickListener()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.NearEventMoChange, self._onNearEventChange, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.BeginTriggerEvent, self._playClickAnim, self)
end

function CachotEventItem:_onEffectLoaded()
	local go = self._clickEffectLoader:getInstGO()

	gohelper.removeEffectNode(go)
end

function CachotEventItem:onStart()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_room_open)
end

function CachotEventItem:updateMo(mo)
	self._anim:Play("open")

	self._mo = mo
	self.go.name = "event_" .. tostring(mo.eventId)

	local eventCo = lua_rogue_event.configDict[mo.eventId]

	if not eventCo then
		logError("没有肉鸽事件配置" .. tostring(mo.eventId))

		return
	end

	self._bigIcon:LoadImage(ResUrl.getV1a6CachotIcon("v1a6_cachot_img_event" .. eventCo.icon))
	UISpriteSetMgr.instance:setV1a6CachotSprite(self._smallIcon, "v1a6_cachot_room_eventicon" .. eventCo.icon)

	local name = eventCo.title
	local len = GameUtil.utf8len(name)
	local showName

	if len >= 2 then
		local first = GameUtil.utf8sub(name, 1, 1)
		local last = GameUtil.utf8sub(name, 2, len - 1)

		showName = string.format("<size=44>%s</size>%s", first, last)
	else
		showName = "<size=44>" .. name
	end

	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	self._txtName.text = showName

	if rogueInfo then
		local showHeart = V1a6_CachotEventConfig.instance:getEventHeartShow(mo.eventId, rogueInfo.difficulty or 1)

		if showHeart then
			gohelper.setActive(self._gocostheartnum, true)

			self._txtcostheartnum.text = showHeart
		else
			gohelper.setActive(self._gocostheartnum, false)
		end

		local recommended = {}
		local bossType = V1a6_CachotEnum.BossType.Normal

		if eventCo.type == V1a6_CachotEnum.EventType.Battle then
			local eventId = eventCo.eventId
			local fightCo = lua_rogue_event_fight.configDict[eventId]

			if not fightCo then
				logError("没有肉鸽战斗事件配置" .. tostring(eventId))

				return
			end

			bossType = fightCo and fightCo.type or bossType

			local battleId = DungeonConfig.instance:getEpisodeBattleId(fightCo.episode)
			local battleConfig = lua_battle.configDict[battleId]

			if battleConfig and not string.nilorempty(battleConfig.monsterGroupIds) then
				local monsterGroupIds = string.splitToNumber(battleConfig.monsterGroupIds, "#")

				for i, v in ipairs(monsterGroupIds) do
					local ids = string.splitToNumber(lua_monster_group.configDict[v].monster, "#")

					for index, id in ipairs(ids) do
						local enemy_career = lua_monster.configDict[id].career

						if not tabletool.indexOf(recommended, enemy_career) then
							table.insert(recommended, enemy_career)
						end
					end
				end
			end
		end

		local roomId = rogueInfo and rogueInfo.room
		local index, count

		if roomId then
			index, count = V1a6_CachotRoomConfig.instance:getRoomIndexAndTotal(roomId)
		end

		if index == count then
			bossType = V1a6_CachotEnum.BossType.Boss
		end

		gohelper.setActive(self._goFrameNormal, bossType == V1a6_CachotEnum.BossType.Normal)
		gohelper.setActive(self._goFrameElite, bossType == V1a6_CachotEnum.BossType.Elite)
		gohelper.setActive(self._goFrameBoss, bossType == V1a6_CachotEnum.BossType.Boss)

		if recommended[1] then
			gohelper.setActive(self._gobattle, true)

			for i = 1, 6 do
				local go = gohelper.findChild(self._gobattle, "icons/" .. i)
				local icon = gohelper.findChildImage(go, "icon")

				if recommended[i] then
					gohelper.setActive(go, true)
					UISpriteSetMgr.instance:setV1a6CachotSprite(icon, "v1a6_cachot_fight_career" .. recommended[i])
				else
					gohelper.setActive(go, false)
				end
			end
		else
			gohelper.setActive(self._gobattle, false)
		end
	end
end

function CachotEventItem:_playClickAnim()
	if self._isSelect then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_room_interaction)
		self._anim:Play("click")
	else
		self._anim:Play("close")
	end
end

function CachotEventItem:_clickThis()
	if V1a6_CachotRoomModel.instance:getIsMoving() then
		return
	end

	if V1a6_CachotRoomModel.instance.isLockPlayerMove then
		return false
	end

	if ViewMgr.instance:isOpen(ViewName.GuideView) or ViewMgr.instance:isOpen(ViewName.GuideView2) then
		return
	end

	if self._isSelect then
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.ClickNearEvent)
	else
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerMoveTo, GameSceneMgr.instance:getCurScene().level:getEventTr(self._mo.index))
	end
end

function CachotEventItem:_onNearEventChange()
	if not self.go or not self.go.activeSelf then
		return
	end

	if not self._mo then
		return
	end

	local nowNearMo = V1a6_CachotRoomModel.instance:getNearEventMo()
	local isSelect = nowNearMo == self._mo

	if self._isSelect ~= isSelect then
		local isFirst = self._isSelect == nil

		self._isSelect = isSelect

		local animName

		self._anim:Play(isSelect and "select" or "unselect", 0, isFirst and 1 or 0)

		if isSelect then
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_room_lit)
		end
	end
end

function CachotEventItem:onDestroy()
	if self._clickEffectLoader then
		self._clickEffectLoader:dispose()

		self._clickEffectLoader = nil
	end

	self._bigIcon:UnLoadImage()
end

return CachotEventItem
