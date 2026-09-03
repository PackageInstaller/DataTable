-- chunkname: @/tmp/or_skill/lua_compile/BlockSp.lua

local assert = _G.assert

module("pkg")

if not _M.__all__ then
	_M.__all__ = _M.__all__
	_M.__all__.StageSp_Crystal_Skill_2 = {
		__new__ = function(prototype, externs, global)
			return
		end,
		passive = function(_env, externs)
			local this, global = _env.this, _env.global
			local exec = _env["$executor"]

			_env.ACTOR = externs.ACTOR

			assert(_env.ACTOR ~= nil, "External variable `ACTOR` is not provided.")

			_env.unit = externs.unit

			assert(_env.unit ~= nil, "External variable `unit` is not provided.")

			_env.event = externs.event

			assert(_env.event ~= nil, "External variable `event` is not provided.")
			exec["@time"]({
				0
			}, _env, function(_env)
				local this, global = _env.this, _env.global

				if global.GetSide(_env, _env.unit) == global.GetSide(_env, _env.ACTOR) and global.PETS(_env, _env.unit) then
					local buffeft1 = global.SpecialNumericEffect(_env, "+CuredoubleFactor", {
						"?Normal"
					}, this.CureRateFactor)

					global.ApplyBuff_Buff(_env, _env.ACTOR, _env.unit, {
						duration = 99,
						group = "StageSp_Crystal_Skill_2",
						timing = 0,
						limit = 1,
						tags = {
							"StageSp_Crystal_Skill_2"
						}
					}, {
						buffeft1
					}, 1, 0)
				end
			end)

			return _env
		end
	}

	return _M
end
