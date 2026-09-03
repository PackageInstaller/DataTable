-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/model/Boll.lua

Boll = class("Boll", objectlua.Object)

Boll:has("_atk", {
	is = "rw"
})
Boll:has("_nickName", {
	is = "rw"
})
Boll:has("_heroId", {
	is = "rw"
})
Boll:has("_hpr", {
	is = "rw"
})
Boll:has("_rid", {
	is = "rw"
})
Boll:has("_sp", {
	is = "rw"
})
Boll:has("_gId", {
	is = "rw"
})
Boll:has("_def", {
	is = "rw"
})
Boll:has("_teamKey", {
	is = "rw"
})
Boll:has("_isMyth", {
	is = "rw"
})
Boll:has("_gInfo", {
	is = "rw"
})
Boll:has("_order", {
	is = "rw"
})
Boll:has("_posInfo", {
	is = "rw"
})
Boll:has("_isProtect", {
	is = "rw"
})
Boll:has("_cPos", {
	is = "rw"
})
Boll:has("_st", {
	is = "rw"
})
Boll:has("_ra", {
	is = "rw"
})
Boll:has("_mPhase", {
	is = "rw"
})
Boll:has("_scaleOffset", {
	is = "rw"
})
Boll:has("_spCount", {
	is = "rw"
})
Boll:has("_mhp", {
	is = "rw"
})

function Boll:initialize(teamkey)
	self._curHp = 0

	super.initialize(self)

	self._teamKey = teamkey
	self._gInfo = {
		gName = "test",
		gId = 1,
		gIndex = 1
	}
end

function Boll:synchronize(data)
	if data.posInfo then
		self._posInfo = data.posInfo
	end

	if data.atk then
		self._atk = data.atk
	end

	if data.nickName then
		self._nickName = data.nickName
	end

	if data.heroId then
		self._heroId = data.heroId

		if data.heroId == "" then
			self._heroId = "LCYShi"
		end
	else
		self._heroId = "LCYShi"
	end

	if data.hpr then
		self._hpr = data.hpr
	end

	if data.rid then
		self._rid = data.rid
	end

	if data.sp then
		self._sp = data.sp
	end

	if data.spCount then
		self._spCount = data.spCount
	end

	if data.gId then
		self._gId = data.gId
	end

	if data.def then
		self._def = data.def
	end

	if data.teamKey then
		self._teamKey = data.teamKey
	end

	if data.isMyth then
		self._isMyth = data.isMyth
	end

	if data.cPos then
		self._cPos = data.cPos
	end

	if data.st then
		self._st = data.st
	end

	if data.ra then
		self._ra = data.ra
	end

	if data.mPhase then
		self._mPhase = data.mPhase
	end

	if data.mhp then
		self._mhp = data.mhp
	end
end

ClubBossBoll = class("ClubBossBoll", Boll)

ClubBossBoll:has("_curHp", {
	is = "rw"
})
ClubBossBoll:has("_maxHp", {
	is = "rw"
})
ClubBossBoll:has("_atkList", {
	is = "rw"
})
ClubBossBoll:has("_previewSp", {
	is = "rw"
})
ClubBossBoll:has("_owner", {
	is = "rw"
})
ClubBossBoll:has("_atkTimes", {
	is = "rw"
})
ClubBossBoll:has("_rid", {
	is = "rw"
})
ClubBossBoll:has("_buff", {
	is = "rw"
})

function ClubBossBoll:initialize(teamkey)
	super.initialize(self, teamkey)

	self._atkList = {}
	self._previewSp = 1
	self._atkTimes = 1
	self._rid = teamkey
end

function ClubBossBoll:synchronize(data)
	if data.atkTimes then
		self._atkTimes = data.atkTimes
	end

	if data.curHp then
		self._curHp = data.curHp
	end

	if data.maxHp then
		self._maxHp = data.maxHp
	end

	if data.atkList then
		for i = 1, #data.atkList do
			self._atkList[#self._atkList + 1] = data.atkList[i]
		end
	end

	if data.buff then
		self._buff = data.buff
	end

	super.synchronize(self, data)
end

function ClubBossBoll:getHpr()
	if self._curHp and self._curHp <= 0 then
		return 0
	end

	return self._curHp / self._maxHp
end
