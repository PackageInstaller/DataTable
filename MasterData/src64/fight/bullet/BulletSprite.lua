BulletSprite = class("BulletSprite", function()
	return cc.Node:create()
end)

require("fight.bullet.BulletSkillExecuter")
require("fight.bullet.BulletHandler")
require("fight.bullet.BulletMoveUpdate")

local var_0_2 = type
local var_0_3 = math.floor
local FightUIElementsManager = require("fight.FightUIElementsManager")

function BulletSprite.create(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = BulletSprite.new()

	var_2_0:init(arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	return var_2_0
end

function BulletSprite:init(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self:initDownload()

	self.info = arg_3_1
	self.fightmsg = arg_3_2
	self.character = arg_3_3
	self.target = arg_3_4
	self.charactertype = arg_3_3.charactertype
	self._unitorder = arg_3_3:getAttackUnitOrder()
	self._filename = arg_3_1.filename
	self._battlefieldlock = false
	self._ishitted = false

	self:checkResource({
		json = EFFECT_SPINE_PATH .. self._filename .. ".json",
		atlas = EFFECT_SPINE_PATH .. self._filename .. ".atlas"
	})
	self:initBulletHandlers()
	self:initBulletInfo(arg_3_1)
	self:registerScriptHandler(function(arg_4_0)
		if arg_4_0 == "exit" and self.skeletonData then
			self.skeletonData:release()

			self.skeletonData = nil
		end
	end)
end

require("controller.filedownloader.download_node_utils"):addDownloadInterface(BulletSprite, "Spine")

function BulletSprite:onDownloadComplete(arg_5_1)
	if not arg_5_1 then
		return
	end

	self:refreshSkeleton(arg_5_1)
end

function BulletSprite:refreshSkeleton(arg_6_1)
	if self.skeletonAnimation then
		self:removeChild(self.skeletonAnimation)

		self.skeletonAnimation = nil
	end

	if self.skeletonData then
		self.skeletonData:release()

		self.skeletonData = nil
	end

	self.skeletonData = SpineCacheManager:addSpineData(arg_6_1.json, arg_6_1.atlas)

	self.skeletonData:retain()

	self.skeletonAnimation = sp.SkeletonAnimation:create(self.skeletonData:getData())

	self:addChild(self.skeletonAnimation)
end

function BulletSprite:play(arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 == nil then
		arg_7_2 = true
	end

	self.skeletonAnimation:setAnimation(0, arg_7_1, arg_7_2)

	if arg_7_3 and arg_7_3 > 0 then
		self.skeletonAnimation:jumpToTime(arg_7_3)
	end
end

function BulletSprite:switchTimeScale(arg_8_1)
	self.skeletonAnimation:setTimeScale(self.skeletonAnimation:getTimeScale() * arg_8_1)
end

function BulletSprite:setTimeScale(arg_9_1)
	self.skeletonAnimation:setTimeScale(arg_9_1)
end

function BulletSprite:getTimeScale()
	return self.skeletonAnimation:getTimeScale()
end

function BulletSprite:destroy(arg_11_1)
	if arg_11_1 and self:playDesTroyAni() then
		return
	end

	self:stop()
	self:setVisible(false)
	self._movingMgr:finish()
	FightManager.destroyBullet(self.index)
	self:runAction(cc.RemoveSelf:create())
end

function BulletSprite:delayDestroy(arg_12_1)
	self:runAction(cc.Sequence:create(cc.DelayTime:create(arg_12_1), cc.CallFunc:create(function()
		self:destroy()
	end)))
end

function BulletSprite.attachUIindex(arg_14_0, arg_14_1)
	arg_14_0.index = arg_14_1
end

function BulletSprite:initBulletInfo(arg_15_1)
	self.size = arg_15_1.size and arg_15_1.size or {
		width = 50,
		height = 50
	}
	self._anchor = arg_15_1.anchor or cc.p(0.5, 0)
	self._basicspeed = arg_15_1.speed
	self._speed = cc.p(0, 0)
	self._maxdistance = arg_15_1.maxdistance
	self._distance = 0
	self._executeBuffer = nil
	self._basedir = self.charactertype == "player" and 1 or -1
	self._modelscale = self.character:getAttribute("model_scale")

	self:setInitPosition(arg_15_1.initpos)
	self:setFinalPosition(arg_15_1.movingtype, arg_15_1.finalpos)
end

function BulletSprite:setInitPosition(arg_16_1)
	self._initpos = {}

	if arg_16_1.object == "self" then
		self:setBulletPostion(self.character, arg_16_1.offsetX, arg_16_1.offsetY)
	elseif arg_16_1.object == "target" then
		self:setBulletPostion(FightManager.getCharacter(self.target), arg_16_1.offsetX, arg_16_1.offsetY)
	end
end

function BulletSprite:setBulletPostion(arg_17_1, arg_17_2, arg_17_3)
	local var_17_0, var_17_1 = arg_17_1:get2DPosition()
	local var_17_2 = var_0_3(var_17_0 + arg_17_2 * arg_17_1:getModelWidth() * arg_17_1:getDirection())
	local var_17_3 = var_0_3(var_17_1 + arg_17_3 * arg_17_1:getModelHeight())

	self:setPosition(cc.p(var_17_2, var_17_3))

	self._initpos._x = var_17_2
	self._initpos._y = var_17_3
	self._initpos._offsetx = arg_17_2
	self._initpos._offsety = arg_17_3
end

function BulletSprite.setBaseDirection(arg_18_0, arg_18_1)
	arg_18_0._basedir = arg_18_1
end

function BulletSprite:getDirection()
	return self._movingMgr:getDirection()
end

function BulletSprite:getSpeed()
	return self._movingMgr:getSpeed()
end

function BulletSprite:addDistance(arg_21_1)
	if self._ishitted then
		return
	end

	self._distance = self._distance + arg_21_1
end

function BulletSprite:getDistance()
	return self._distance
end

function BulletSprite.setHitted(arg_23_0, arg_23_1)
	arg_23_0._ishitted = arg_23_1
end

function BulletSprite:isHitted()
	return self._ishitted
end

function BulletSprite:move(arg_25_1, arg_25_2)
	local var_25_0, var_25_1 = self:getPosition()

	self:setPosition(cc.p(var_25_0 + arg_25_1, var_25_1 + arg_25_2))
end

function BulletSprite:getStandardPosition()
	local var_26_0, var_26_1 = self:getPosition()

	return var_0_3(var_26_0 + self:getRootPosition().x * STANDARD_SCALE * self._modelscale * self._movingMgr:getDirection() - (var_26_1 - STANDARD_POSY) / MAP_OFFSET_SIN * MAP_OFFSET_COS)
end

function BulletSprite:get2DPosition()
	local var_27_0, var_27_1 = self:getPosition()
	local var_27_2 = self:getRootPosition()

	return var_0_3(var_27_0 + var_27_2.x * STANDARD_SCALE * self._modelscale * self._movingMgr:getDirection()), var_0_3(var_27_1 + var_27_2.y * STANDARD_SCALE * self._modelscale)
end

function BulletSprite:getRootPosition()
	return self.skeletonAnimation:getRootPosition()
end

function BulletSprite:switchDirection()
	self:setScale(self._movingMgr:getDirection() * STANDARD_SCALE * self.character:getAttribute("model_scale"), STANDARD_SCALE * self.character:getAttribute("model_scale"))
end

function BulletSprite:getRelativeDir(arg_30_1)
	local var_30_0 = FightManager.getCharacter(arg_30_1)

	if not var_30_0 then
		return self:getDirection()
	end

	local var_30_1 = self:getStandardPosition()
	local var_30_2 = var_30_0:getStandardPosition()

	if var_30_1 == var_30_2 then
		return self:getDirection()
	elseif var_30_1 < var_30_2 then
		return 1
	else
		return -1
	end
end

function BulletSprite:getModelWidth()
	return self.size.width
end

function BulletSprite:getModelHeight()
	return self.size.height
end

function BulletSprite:run()
	if self.info.movingani then
		self:play(self.info.movingani)
	end

	self._movingMgr:initCheck(self)

	self._running = true
end

function BulletSprite.stop(arg_34_0)
	arg_34_0._running = false
end

function BulletSprite:pauseAni()
	self.skeletonAnimation:pause()
	self:pause()

	self.lockon = true
end

function BulletSprite:resumeAni()
	self.lockon = false

	if not self._battlefieldlock then
		self.skeletonAnimation:resume()
		self:resume()
	end
end

function BulletSprite:lockBattleField()
	self._battlefieldlock = true

	self.skeletonAnimation:pause()
	self:pause()
end

function BulletSprite:unlockBattleField()
	self._battlefieldlock = false

	if not self.lockon then
		self.skeletonAnimation:resume()
		self:resume()
	end
end

function BulletSprite:update(arg_39_1)
	if not self._running then
		return
	end

	if self._battlefieldlock then
		return
	end

	if self.lockon then
		self._movingMgr:setSpeed(0, arg_39_1)

		return
	end

	if self._ondestroy then
		self._movingMgr:setSpeed(0, arg_39_1)
		self:updateBulletHandlers(arg_39_1)

		return
	end

	if self._distance >= self._maxdistance then
		self:destroy(true)

		return
	end

	self:updateBulletHandlers(arg_39_1)

	if self.yield then
		self._movingMgr:setSpeed(0, arg_39_1)

		return
	end

	self._movingMgr:update(arg_39_1, self)
end

function BulletSprite:executeWithDestroy(arg_40_1, arg_40_2)
	local var_40_1 = arg_40_1.totalframe

	self:play(arg_40_1.animation, false, arg_40_1.startframe or 0)

	if var_0_2(arg_40_2) == "table" then
		for iter_40_0, iter_40_1 in pairs(arg_40_2) do
			self:runSkillExetbl(arg_40_1, iter_40_1)
		end
	else
		self:runSkillExetbl(arg_40_1, arg_40_2)
	end

	self:pushInSkillCompleteHandler(var_40_1 / 30, arg_40_1.action_on_complete)
end

function BulletSprite:runSkillExetbl(arg_41_1, arg_41_2)
	if arg_41_1.exe_tbl then
		for iter_41_0, iter_41_1 in ipairs(arg_41_1.exe_tbl) do
			self:pushInAttackHandler(iter_41_1.frame / 30, iter_41_1, {
				run_node = self,
				assigned_target = arg_41_2,
				msg = self.fightmsg
			})
		end
	end
end

function BulletSprite:execute(arg_42_1, arg_42_2)
	if var_0_2(arg_42_2) == "table" then
		for iter_42_0, iter_42_1 in pairs(arg_42_2) do
			self:runSkillExetbl(arg_42_1, iter_42_1)
		end
	else
		self:runSkillExetbl(arg_42_1, arg_42_2)
	end
end

function BulletSprite:doSequence(arg_43_1)
	if not self.character or not self.character._instance then
		return false
	end

	for iter_43_0 = 1, #arg_43_1 do
		if not self:skillexecute(arg_43_1[iter_43_0].method, arg_43_1[iter_43_0].param, arg_43_1[iter_43_0].operator) then
			return false
		end
	end

	return true
end

function BulletSprite:skillexecute(arg_44_1, arg_44_2, arg_44_3)
	if self[arg_44_1] then
		return self[arg_44_1](self, arg_44_2, arg_44_3)
	else
		return self.character:skillexecute(self.fightmsg, arg_44_1, arg_44_2, arg_44_3)
	end
end

function BulletSprite:playDesTroyAni()
	if not self.info.destroy then
		return false
	end

	local var_45_0 = self.info.destroy.animation

	if not self.info.destroy.animation then
		return false
	end

	self:play(var_45_0, false)

	if self.info.destroy.exe_tbl then
		for iter_45_0, iter_45_1 in ipairs(self.info.destroy.exe_tbl) do
			self:pushInAttackHandler(iter_45_1.frame / 30, iter_45_1, {
				run_node = self,
				msg = self.fightmsg
			})
		end
	end

	self:pushInBulletDestroyHandler(self.info.destroy.totalframe / 30)

	self._ondestroy = true

	return true
end

function BulletSprite:is_target_teammate(arg_46_1)
	return self.charactertype == (arg_46_1.charactertype == "slave" and arg_46_1.index:match("slave(.+)") or arg_46_1.charactertype)
end

function BulletSprite:is_locking_teammate(arg_47_1)
	return self.charactertype == arg_47_1
end
