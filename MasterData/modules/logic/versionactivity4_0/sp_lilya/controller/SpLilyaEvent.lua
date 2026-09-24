-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/controller/SpLilyaEvent.lua

module("modules.logic.versionactivity4_0.sp_lilya.controller.SpLilyaEvent", package.seeall)

local SpLilyaEvent = _M
local _get = GameUtil.getUniqueTb()

SpLilyaEvent.EnemyCreate = _get()
SpLilyaEvent.EnemyMove = _get()
SpLilyaEvent.EnemyStateChange = _get()
SpLilyaEvent.EnemyDestroy = _get()
SpLilyaEvent.EnemyAimChange = _get()
SpLilyaEvent.EnemyLifeChange = _get()
SpLilyaEvent.BulletCreate = _get()
SpLilyaEvent.BulletMove = _get()
SpLilyaEvent.BulletExplode = _get()
SpLilyaEvent.BulletDestroy = _get()
SpLilyaEvent.WaveUpdate = _get()
SpLilyaEvent.WaveWaitUpdate = _get()
SpLilyaEvent.TimeUpdate = _get()
SpLilyaEvent.PowerUpdate = _get()
SpLilyaEvent.HpUpdate = _get()
SpLilyaEvent.PlayerStateChange = _get()
SpLilyaEvent.EnergyUpdate = _get()
SpLilyaEvent.PlayerMoveEvent = _get()
SpLilyaEvent.PlayerAimState = _get()
SpLilyaEvent.DamageNumUpdate = _get()
SpLilyaEvent.GameEnd = _get()
SpLilyaEvent.GameReset = _get()
SpLilyaEvent.GameStart = _get()
SpLilyaEvent.GamePause = _get()
SpLilyaEvent.GameResume = _get()

return SpLilyaEvent
