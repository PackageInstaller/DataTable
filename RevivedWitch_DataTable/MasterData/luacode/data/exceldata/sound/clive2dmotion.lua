-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/data/exceldata/sound/clive2dmotion.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local clive2dmotion = {}
clive2dmotion.Data = {
[1] = {id = 1, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[2] = {id = 2, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[3] = {id = 3, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[4] = {id = 4, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[5] = {id = 5, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[6] = {id = 6, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[7] = {id = 7, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[8] = {id = 8, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[9] = {id = 9, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[10] = {id = 10, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[11] = {id = 11, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[12] = {id = 12, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[13] = {id = 13, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[14] = {id = 14, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[15] = {id = 15, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[16] = {id = 16, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[17] = {id = 17, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[18] = {id = 18, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[19] = {id = 19, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[20] = {id = 20, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[21] = {id = 21, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[22] = {id = 22, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[23] = {id = 23, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[24] = {id = 24, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[25] = {id = 25, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[26] = {id = 26, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[27] = {id = 27, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[28] = {id = 28, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[29] = {id = 29, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[30] = {id = 30, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[31] = {id = 31, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[32] = {id = 32, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[33] = {id = 33, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[34] = {id = 34, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 4, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[35] = {id = 35, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[36] = {id = 36, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[37] = {id = 37, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[38] = {id = 38, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[39] = {id = 39, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 0}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[40] = {id = 40, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[41] = {id = 41, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[42] = {id = 42, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[43] = {id = 43, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[44] = {id = 44, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[45] = {id = 45, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[46] = {id = 46, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[47] = {id = 47, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[48] = {id = 48, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[49] = {id = 49, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[51] = {id = 51, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[52] = {id = 52, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[53] = {id = 53, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[54] = {id = 54, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[55] = {id = 55, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[56] = {id = 56, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[57] = {id = 57, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[58] = {id = 58, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[59] = {id = 59, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[60] = {id = 60, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[61] = {id = 61, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[63] = {id = 63, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[64] = {id = 64, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[65] = {id = 65, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[66] = {id = 66, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[67] = {id = 67, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[68] = {id = 68, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[69] = {id = 69, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[70] = {id = 70, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[71] = {id = 71, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[72] = {id = 72, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[73] = {id = 73, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[74] = {id = 74, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[75] = {id = 75, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[76] = {id = 76, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[78] = {id = 78, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[79] = {id = 79, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[80] = {id = 80, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[81] = {id = 81, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[82] = {id = 82, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[83] = {id = 83, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[84] = {id = 84, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[85] = {id = 85, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[86] = {id = 86, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[88] = {id = 88, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[89] = {id = 89, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[90] = {id = 90, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[91] = {id = 91, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[92] = {id = 92, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[93] = {id = 93, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[94] = {id = 94, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[95] = {id = 95, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[97] = {id = 97, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[98] = {id = 98, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[99] = {id = 99, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[100] = {id = 100, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[101] = {id = 101, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[102] = {id = 102, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[103] = {id = 103, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[104] = {id = 104, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[105] = {id = 105, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 2, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 1}
, Introduction = 1, Login = 1}
, 
[106] = {id = 106, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[107] = {id = 107, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[108] = {id = 108, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[109] = {id = 109, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[110] = {id = 110, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[111] = {id = 111, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[112] = {id = 112, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[113] = {id = 113, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[115] = {id = 115, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[116] = {id = 116, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[117] = {id = 117, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[118] = {id = 118, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[119] = {id = 119, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 2, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 1}
, Introduction = 1, Login = 1}
, 
[120] = {id = 120, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[121] = {id = 121, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[122] = {id = 122, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[123] = {id = 123, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[124] = {id = 124, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
, 
[126] = {id = 126, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 2, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 1}
, Introduction = 1, Login = 1}
, 
[130] = {id = 130, LevelUp = 10, LimitUp = 10, RareUp = 10, 
Impression = {2, 2, 10, 10, 13}
, 
touch = {12, 5, 13, 12, 5}
, NormalGift = 2, FavoriteGift = 4, Standby = 2, Formation = 2, Adventure = 2, OpenBox = 0, ManaTree = 0, LifeHealing = 2, BattleStart = 5, 
SkillCV = {5, 5, 0, 0, 0}
, 
Attacked = {5, 12}
, Revive = 10, Victory = 1, Defeat = 11, BattleKill = 10, 
YardTouch = {2, 2}
, Dispatch = 2, Withdraw = 2, Summory = 1, 
Conversation = {2, 2, 2, 2}
, 
Emotion = {4, 5, 0}
, Introduction = 1, Login = 1}
}
clive2dmotion.AllIds = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 78, 79, 80, 81, 82, 83, 84, 85, 86, 88, 89, 90, 91, 92, 93, 94, 95, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 126, 130}
return clive2dmotion

