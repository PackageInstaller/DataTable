local state = BaseState:New(BattleState.PreloadResource)
local battle_component = nil
local scene = nil

local function LoadUI()
     --scene:AddPreloadAssetBundle("UI/Prefabs/UI/Battle/Common")
     --scene:AddPreloadResource(UIConfig[UIWindowNames.UIBuffGlances].PrefabPath, typeof(CS.UnityEngine.GameObject), 1)
     ----scene:AddPreloadResource(UIConfig[UIWindowNames.UIBattleAwake].PrefabPath, typeof(CS.UnityEngine.GameObject), 1)
     ----scene:AddPreloadResource(UIConfig[UIWindowNames.UIBattlePause].PrefabPath, typeof(CS.UnityEngine.GameObject), 1)
     ----scene:AddPreloadResource(UIConfig[UIWindowNames.UIBattleRevive].PrefabPath, typeof(CS.UnityEngine.GameObject), 1)
     --scene:AddPreloadResource(UIConfig[UIWindowNames.UIBattleShowRound].PrefabPath, typeof(CS.UnityEngine.GameObject), 1)
     scene:AddPreloadResource(UIConfig[UIWindowNames.UIBossEffect].PrefabPath, typeof(CS.UnityEngine.GameObject), 1)
     scene:AddPreloadResource(UIConfig[UIWindowNames.UIBattleSettle].PrefabPath, typeof(CS.UnityEngine.GameObject), 1)
     --scene:AddPreloadResource(UIConfig[UIWindowNames.UIBattleLose].PrefabPath, typeof(CS.UnityEngine.GameObject), 1)
     ----scene:AddPreloadResource(UIConfig[UIWindowNames.ToolTipFirst].PrefabPath, typeof(CS.UnityEngine.GameObject), 1)
     --local GuideComplete, GuideStep, run = Game.Scene:GetComponent("GuideComponent"):GetCurrentData()
     --if run then
     --     scene:AddPreloadResource(UIConfig[UIWindowNames.UINoviceGuide].PrefabPath, typeof(CS.UnityEngine.GameObject), 1)
     --end
end

local function LoadRes(card, zSsUnit)
     -- 预加载角色预制体和控制器
     local path
     local unitName -- 单位的名字：旧资源会有前面编号  新资源没有编号
     if zSsUnit.NewRes == 1 then
          local unitSplits = string.split(zSsUnit.AbDir, "_")
          unitName = unitSplits[#unitSplits]..(card.Skin == 0 and 1 or card.Skin)
          path = zSsUnit.AbDir.."/"..unitName.."/Model/"..unitName..".prefab"
     else
          local unitSplits = string.split(zSsUnit.AbDir, "/")
          unitName = unitSplits[#unitSplits]
          path = zSsUnit.AbDir.."/Model/"..unitName..".prefab"
     end
     local abPath1 = zSsUnit.AbDir.."/"..unitName.."/Battle"
     local abPath2 = zSsUnit.AbDir.."/"..unitName.."/Model"
     local abPath4 = zSsUnit.AbDir.."/Effects"
     --local abPath5 = zSsUnit.AbDir.."/Sounds"
     scene:AddPreloadAssetBundle(abPath1)
     scene:AddPreloadAssetBundle(abPath2)
     scene:AddPreloadAssetBundle(abPath4)
     --scene:AddPreloadAssetBundle(abPath5)
end

local function LoadFriendResource()
     -- 预加载所有友方角色和支援角色资源
     local againstComponent = Game.Scene:GetComponent("AgainstComponent") --对战组件
     local cardComponent = Game.Scene.Player:GetComponent("CardComponent") --角色组件
     local supCardComponent = Game.Scene:GetComponent("SupCardComponent") --支援角色组件
     -- 测试用：加载所有角色
     --table.walk(Z_Skin, function (k, v)
     --     local card = {TemplateId = v.BelongCard, SkinId = v.Stage}
     --     local zCard = Z_Card[card.TemplateId] --角色配置
     --     local zSsUnit = Z_SsUnit:GetConfig(zCard.SsUnitId)--单位配置
     --     LoadRes(card, zSsUnit)
     --end)

     for _, unit in ipairs(againstComponent.PlayerFormation.units) do
          local battlecharacter = Game.Registry:NewObject("BattleCharacter")
          local battleUnitComponent = battlecharacter:AddComponent("BattleUnitComponent")
          battleUnitComponent:InitForCard(unit)
          battlecharacter:SetFromBattleUnitComponent()
          local zCard = Z_Card[battlecharacter.TemplateId] --角色配置
          local zSsUnit = Z_SsUnit:GetConfig(zCard.SsUnitId)--单位配置
          LoadRes(battlecharacter, zSsUnit)
     end

     ---- 预加载主角
     --local abPath1 = "SsUnit/000_NanZhuJue/NanZhuJue1/Battle"
     --local abPath2 = "SsUnit/000_NanZhuJue/NanZhuJue1/Model"
     --scene:AddPreloadAssetBundle(abPath1)
     --scene:AddPreloadAssetBundle(abPath2)
end

local function LoadEnemyResource()
     local againstComponent = Game.Scene:GetComponent("AgainstComponent")
     for _, unit in ipairs(againstComponent.EnemyPlayerFormation.units) do
          local battlecharacter = Game.Registry:NewObject("BattleCharacter")
          local battleUnitComponent = battlecharacter:AddComponent("BattleUnitComponent")
          battleUnitComponent:InitForCard(unit)
          battlecharacter:SetFromBattleUnitComponent()
          local zCard = Z_Card[battlecharacter.TemplateId] --角色配置
          local zSsUnit = Z_SsUnit:GetConfig(zCard.SsUnitId)--单位配置
          LoadRes(battlecharacter, zSsUnit)
     end     
end

local function LoadMonsterResource()
     local preloadEnemy = function(v)
          -- 预加载角色预制体和控制器
          local zfigureAsset = v.FigureAssetConfig
          local zSsUnit = Z_SsUnit:GetConfig(zfigureAsset.SsUnitId)
          --print("--预加载敌方角色:"..zCard.Name)
          --local headPath = srAvatarPathPrefix..zCard.Id.."_"..skinId..".png"
          --scene:AddPreloadResource(headPath, typeof(Sprite))

          local path
          local unitName -- 单位的名字：旧资源会有前面编号  新资源没有编号
          if zSsUnit.NewRes == 1 then
               --local unitSplits = string.split(zSsUnit.AbDir, "_")
               --unitName = unitSplits[#unitSplits]..skinId
               --path = zSsUnit.AbDir.."/"..unitName.."/Model/"..unitName..".prefab"

               --local abPath1 = zSsUnit.AbDir.."/"..unitName.."/Battle"
               --local abPath2 = zSsUnit.AbDir.."/"..unitName.."/Model"
               --local abPath3 = zSsUnit.AbDir.."/"..unitName.."/UI"
               --local abPath4 = zSsUnit.AbDir.."/Effects"
               --local abPath5 = zSsUnit.AbDir.."/Common"
               --scene:AddPreloadAssetBundle(abPath1)
               --scene:AddPreloadAssetBundle(abPath2)
               ----scene:AddPreloadAssetBundle(abPath3)
               --scene:AddPreloadAssetBundle(abPath4)
               ----scene:AddPreloadAssetBundle(abPath5)
          else
               local unitSplits = string.split(zSsUnit.AbDir, "/")
               unitName = unitSplits[#unitSplits]
               path = zSsUnit.AbDir.."/Model/"..unitName..".prefab"

               local abPath1 = zSsUnit.AbDir.."/Battle"
               --local abPath2 = zSsUnit.AbDir.."/Sounds"
               local abPath3 = zSsUnit.AbDir.."/Model"
               scene:AddPreloadAssetBundle(abPath1)
               --scene:AddPreloadAssetBundle(abPath2)
               scene:AddPreloadAssetBundle(abPath3)
          end

          --local resPath
          --if zSsUnit.NewRes == 1 then
          --     resPath = zSsUnit.AbDir.."/"..unitName.."/Battle/"..unitName..".controller"
          --else
          --     resPath = zSsUnit.AbDir.."/Battle/SsUnitAnimator"..".controller"
          --end
          --scene:AddPreloadResource(path, typeof(GameObject), 1) --角色模型
          --scene:AddPreloadResource(resPath, typeof(RuntimeAnimatorController)) --角色动作

          --if skinId == nil or skinId > 100 then skinId = 1 end
          --skinId = (skinId == 0 and {1} or {skinId})[1]
          --local subPath = "UI/CardMiddle/"..zCard.Id.."_"..skinId..".png"
          --scene:AddPreloadResource(subPath, typeof(Sprite))

          --if zCard.PassiveSkill ~= 0 then
          --     local zSkill = Z_Skill[zCard.PassiveSkill]
          --     if zSkill then
          --          scene:AddPreloadResource("UI/SkillIcon/"..zSkill.SkillIcon..".png", typeof(Sprite))
          --     end
          --end
          --if zCard.GeneralAtk ~= 0 then
          --     local zSkill = Z_Skill[zCard.GeneralAtk]
          --     if zSkill then
          --          scene:AddPreloadResource("UI/SkillIcon/"..zSkill.SkillIcon..".png", typeof(Sprite))
          --     end
          --end
          --if zCard.Skill1 ~= 0 then
          --     local zSkill = Z_Skill[zCard.Skill1]
          --     if zSkill then
          --          scene:AddPreloadResource("UI/SkillIcon/"..zSkill.SkillIcon..".png", typeof(Sprite))
          --     end
          --end
          --if zCard.Skill2 ~= 0 then
          --     local zSkill = Z_Skill[zCard.Skill2]
          --     if zSkill then
          --          scene:AddPreloadResource("UI/SkillIcon/"..zSkill.SkillIcon..".png", typeof(Sprite))
          --     end
          --end

          --CoPreLoadVoice(v.id, scene)
          --CoPreloadSkillSound(v.id, scene)
          --local zSkillEfx = {}
          --local animEvt = zSsUnit.animEvt
          --if animEvt.Atk~=nil and animEvt.Atk.SkillEfxId~=0 then
          --     zSkillEfx[animEvt.Atk.Name]=Z_SkillEfx:GetConfig(animEvt.Atk.SkillEfxId)
          --end
          --if animEvt.Skl01~=nil and animEvt.Skl01.SkillEfxId~=0 then
          --     zSkillEfx[animEvt.Skl01.Name]=Z_SkillEfx:GetConfig(animEvt.Skl01.SkillEfxId)
          --end
          --if animEvt.Skl02~=nil and animEvt.Skl02.SkillEfxId~=0 then
          --     zSkillEfx[animEvt.Skl02.Name]=Z_SkillEfx:GetConfig(animEvt.Skl02.SkillEfxId)
          --end
          --if animEvt.Skl03~=nil and animEvt.Skl03.SkillEfxId~=0 then
          --     zSkillEfx[animEvt.Skl03.Name]=Z_SkillEfx:GetConfig(animEvt.Skl03.SkillEfxId)
          --end
          --if zCard.GeneralAtk ~= 0 then
          --     PreloadEffect(zSkillEfx.Atk, zSsUnit, scene)
          --end
          --if zCard.Skill1 ~= 0 then
          --     PreloadEffect(zSkillEfx.Skl01, zSsUnit, scene)
          --end
          --if zCard.Skill2 ~= 0 then
          --     PreloadEffect(zSkillEfx.Skl02, zSsUnit, scene)
          --end
     end

     -- 预加载怪物
     if battle_component.ZBattleLevel.Batch1 ~= nil then
          local batch = battle_component.against_component:LoadBatch(battle_component.ZBattleLevel.Batch1)
          if batch ~= nil then
               table.walk(batch.Monsters,function (k, v)
                    preloadEnemy(v)
               end)
          end
     end
     if battle_component.ZBattleLevel.Batch2 ~= nil then
          local batch = battle_component.against_component:LoadBatch(battle_component.ZBattleLevel.Batch2)
          if batch ~= nil then
               table.walk(batch.Monsters,function (k,v)
                    preloadEnemy(v)
               end)
          end
     end
     if battle_component.ZBattleLevel.Batch3 ~= nil then
          local batch = battle_component.against_component:LoadBatch(battle_component.ZBattleLevel.Batch3)
          if batch ~= nil then
               table.walk(batch.Monsters,function (k,v)
                    preloadEnemy(v)
               end)
          end
     end
end

function state:OnInit()
     battle_component = Game.Scene:GetComponent("BattleComponent")
end

function state:OnEnter()
     print("--开始预加载=================")
     -- 预加载资源
     scene = battle_component.loadingScene
     local Config = battle_component.against_component:GetZSection()
     battle_component.level_name = Config.LevelTitle --章节名称

     -- 加载场景资源
     battle_component.zScene = Z_Scene[Config.SceneId]
     battle_component.scene_res_path = "Scene/"..battle_component.zScene.SceneName.."/Scene.prefab" --场景预制体路径
     scene:AddPreloadResource(battle_component.scene_res_path, typeof(GameObject), 1) --加载场景预制体

     -- 己方单位预加载
     LoadFriendResource()

     -- 敌方单位预加载
     local against_component = Game.Scene:GetComponent("AgainstComponent")
     if against_component.LevelType == LevelType.LevelTypeArena then
          LoadEnemyResource()
     else
          LoadMonsterResource()
     end

     -- UI预加载
     LoadUI()

     -- 通用buff特效预加载
     scene:AddPreloadAssetBundle("SsUnit/Common")
     scene:AddPreloadResource("UI/Atlas/BattleTip_"..LangUtil.GetLangType().."/SpriteAtlas.spriteatlas", typeof(CS.UnityEngine.U2D.SpriteAtlas))
     scene:AddPreloadResource("UI/Effects/Battle/Battle.prefab", typeof(GameObject), 1)
     
     --if not string.IsNullOrEmpty(battle_component.ZBattleLevel.Bgm) then
     --     if battle_component.ZBattleLevel.bgmType == nil then
     --          scene:AddPreloadResource(Game.Scene:GetComponent("BgmComponent"):GetFullPath(BgmType.Battle, battle_component.ZBattleLevel.Bgm), typeof(AudioClip))
     --          --Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.Battle, battle_component.ZBattleLevel.Bgm) --播放bgm
     --     else
     --          scene:AddPreloadResource(Game.Scene:GetComponent("BgmComponent"):GetFullPath(battle_component.ZBattleLevel.bgmType, battle_component.ZBattleLevel.Bgm), typeof(AudioClip))
     --     end
     --end

     --scene:AddPreloadAssetBundle("Sound/Battle")
     --table.walk(CommonSoundPath, function (k, v)
     --     scene:AddPreloadResource(v, typeof(AudioClip))
     --end)
     --LoadBattleArrayVoice()

     --scene:AddPreloadResource("UI/Atlas/BattleNumeric/SpriteAtlas.spriteatlas", typeof(CS.UnityEngine.U2D.SpriteAtlas))
     print("--成功添加预加载资源")
end

function state:OnUpdate()
end

function state:OnLeave()
end

return state
