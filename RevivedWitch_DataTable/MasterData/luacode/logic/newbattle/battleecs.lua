-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/newbattle/battleecs.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BattleECS = {
Components = {TypeComponent = require("logic.newbattle.component.typecomponent"), PositionComponent = require("logic.newbattle.component.positioncomponent"), HpComponent = require("logic.newbattle.component.hpcomponent"), BehaviorComponent = require("logic.newbattle.component.behaviorcomponent"), SkillComponent = require("logic.newbattle.component.skillcomponent"), PhysicsComponent = require("logic.newbattle.component.physicscomponent"), SkillEffectComponent = require("logic.newbattle.component.skilleffectcomponent"), AnimationEventComponent = require("logic.newbattle.component.animationeventcomponent"), AttackComponent = require("logic.newbattle.component.attackcomponent"), DefenseComponent = require("logic.newbattle.component.defensecomponent"), BuffComponent = require("logic.newbattle.component.buffcomponent"), FlySkillDataComponent = require("logic.newbattle.component.flyskilldatacomponent"), RoleDeadCountComponent = require("logic.newbattle.component.roledeadcountcomponent"), DeadDisappearCountComponent = require("logic.newbattle.component.deaddisappearcountcomponent"), SummonDataComponent = require("logic.newbattle.component.summondatacomponent"), CreateRoleComponent = require("logic.newbattle.component.createrolecomponent")}
, 
Systems = {HpSystem = require("logic.newbattle.system.hpsystem"), BehaviorSystem = require("logic.newbattle.system.behaviorsystem"), AnimationSystem = require("logic.newbattle.system.animationsystem"), SkillSystem = require("logic.newbattle.system.skillsystem"), PhysicsSystem = require("logic.newbattle.system.physicssystem"), ReleaseSystem = require("logic.newbattle.system.releasesystem"), SkillEffectSystem = require("logic.newbattle.system.skilleffectsystem"), ViewMoveSystem = require("logic.newbattle.system.viewmovesystem"), SpritePhysicsSystem = require("logic.newbattle.system.spritephysicssystem"), BuffSystem = require("logic.newbattle.system.buffsystem"), AnimationEventSystem = require("logic.newbattle.system.animationeventsystem"), RoleDeadCountSystem = require("logic.newbattle.system.roledeadcountsystem"), DeadDisappearCountSystem = require("logic.newbattle.system.deaddisappearcountsystem"), FlySkillDataSystem = require("logic.newbattle.system.flyskilldatasystem"), CreateRoleSystem = require("logic.newbattle.system.createrolesystem")}
, 
Utility = {Utility = require("logic.newbattle.utility.utility"), PhysicsUtility = require("logic.newbattle.utility.physicsutility"), ProtocolUtility = require("logic.newbattle.utility.protocolutility"), BuffUtility = require("logic.newbattle.utility.buffutility"), AnimationUtility = require("logic.newbattle.utility.animationutility"), DataUtility = require("logic.newbattle.utility.datautility")}
, 
Buff = {Buff = require("logic.newbattle.buff.buff")}
}
return BattleECS

