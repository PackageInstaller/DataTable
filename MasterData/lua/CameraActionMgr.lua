--镜头控制管理

local CameraActionDatas = require "CameraActionDatas";

local this = {};


--场景初始视角
this.scene_origin = "scene_origin";

--进入战斗场景初始位置
this.fight_start = "fight_start";
--战斗开场
this.fight_enter = "fight_enter";
--周目切换
this.fight_wave = "fight_wave";


--我方输入
this.input_my_turn = "input_my_turn";
--敌方输入
this.input_enemy_turn = "input_enemy_turn";

--角色开始行动
this.character_action_start = "character_action_start";

--选择我方目标
this.sel_my_character = "sel_my_character";
--选择敌方目标
this.sel_enemy_character = "sel_enemy_character";

--事件结算镜头
this.round_event = "round_event";
--胜利镜头
this.winner = "winner";

--获取目标角色FireBall数据
function this:GetDatas(name)
    
    if(StringUtil:IsEmpty(name))then
        return nil;
    end

    if(self.cameraActionDatas == nil)then
        self.cameraActionDatas = {};
    end

    if(self.cameraActionDatas[name] == nil)then
        local targetName = CameraActionDatas[name];
        if(targetName ~= nil)then
            self.cameraActionDatas[name] = require ("" .. targetName);
        end
    end
    return self.cameraActionDatas[name];
end

return this;