-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/model/DivineXingJiangClgGameModel.lua

module("logic.extensions.divinexingjiangclg.model.DivineXingJiangClgGameModel", package.seeall)

local DivineXingJiangClgGameModel = class("DivineXingJiangClgGameModel", BaseModel)

DivineXingJiangClgGameModel.GameBefore = 1
DivineXingJiangClgGameModel.GamePlaying = 2
DivineXingJiangClgGameModel.GameStop = 3
DivineXingJiangClgGameModel.GameEnd = 4
DivineXingJiangClgGameModel.Astro = {
	"摩羯座",
	"水瓶座",
	"双鱼座",
	"白羊座",
	"金牛座",
	"双子座",
	"巨蟹座",
	"狮子座",
	"处女座",
	"天秤座",
	"天蝎座",
	"射手座"
}
DivineXingJiangClgGameModel.PillarNum = 5

function DivineXingJiangClgGameModel:ctor()
	return
end

function DivineXingJiangClgGameModel:onInit()
	self:onReset()
end

function DivineXingJiangClgGameModel:onReset()
	self._maxHp = checknumber(DivineXingJiangClgConfig.instance:getCommonValue("MAX_HP"))
	self._maxCountdown = checknumber(DivineXingJiangClgConfig.instance:getCommonValue("GAME_TIME"))
	self._moveSpeed = checknumber(DivineXingJiangClgConfig.instance:getCommonValue("MOVE_SPEED"))
	self._horizontalPoleHeight = checknumber(DivineXingJiangClgConfig.instance:getCommonValue("HORIZONTAL_POLE_HEIGHT"))
	self._spaceHorizontalPole = checknumber(DivineXingJiangClgConfig.instance:getCommonValue("HORIZONTAL_POLE_MIN_DISTANCE"))

	local interval = GameUtil.jsonToTable(DivineXingJiangClgConfig.instance:getCommonValue("CREATE_TIME_INTERVAL"))

	self._dropItemInterval = {
		interval[1],
		interval[2]
	}

	local createNum = GameUtil.jsonToTable(DivineXingJiangClgConfig.instance:getCommonValue("CREATE_NUM"))

	self._dropItemCreateNum = {
		createNum[1],
		createNum[2]
	}
	self._gameState = DivineXingJiangClgGameModel.GameBefore
	self._curHp = self._maxHp
	self._curCountdown = self._maxCountdown
	self._gameScore = 0
end

function DivineXingJiangClgGameModel:getGameScore()
	return self._gameScore
end

function DivineXingJiangClgGameModel:addGameScore()
	self._gameScore = self._gameScore + 1
end

function DivineXingJiangClgGameModel:getMaxHp()
	return self._maxHp
end

function DivineXingJiangClgGameModel:getCurHp()
	return self._curHp
end

function DivineXingJiangClgGameModel:isDead()
	return self._curHp == 0
end

function DivineXingJiangClgGameModel:subHp()
	self._curHp = Mathf.Max(0, self._curHp - 1)
end

function DivineXingJiangClgGameModel:getMaxCountdown()
	return self._maxCountdown
end

function DivineXingJiangClgGameModel:updateCountdown()
	self._curCountdown = self._curCountdown - Time.deltaTime

	if self._curCountdown >= 0 then
		self._curCountdown = self._curCountdown or 0
	end
end

function DivineXingJiangClgGameModel:getCountdown()
	return self._curCountdown
end

function DivineXingJiangClgGameModel:isNoTime()
	return self._curCountdown <= 0
end

function DivineXingJiangClgGameModel:getGameState()
	return self._gameState
end

function DivineXingJiangClgGameModel:startGame()
	self._gameState = DivineXingJiangClgGameModel.GamePlaying
end

function DivineXingJiangClgGameModel:gameOver()
	self._gameState = DivineXingJiangClgGameModel.GameEnd
end

function DivineXingJiangClgGameModel:getDropItemInterval()
	return self._dropItemInterval
end

function DivineXingJiangClgGameModel:getRandomDropInterval()
	local time = math.random(self._dropItemInterval[1], self._dropItemInterval[2])

	printInfo("test 随机生成的时间间隔（秒）：", time)

	return time
end

function DivineXingJiangClgGameModel:getRandomCreateNum()
	local num = math.random(self._dropItemCreateNum[1], self._dropItemCreateNum[2])

	printInfo("test 随机生成掉落物数量（个）：", num)

	return num
end

function DivineXingJiangClgGameModel:getDropMoveSpeed()
	return self._moveSpeed
end

function DivineXingJiangClgGameModel:getHorizontalPoleSpace()
	return self._spaceHorizontalPole
end

function DivineXingJiangClgGameModel:getHorizontalPoleHeight()
	return self._horizontalPoleHeight
end

DivineXingJiangClgGameModel.instance = DivineXingJiangClgGameModel.New()

return DivineXingJiangClgGameModel
