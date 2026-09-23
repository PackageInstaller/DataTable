--lua������
UnityEngine = CS.UnityEngine
GameObject = UnityEngine.GameObject
Time = UnityEngine.Time


--���÷���
--YieldReturn = (require "cs_coroutine").yield_return
--WaitForSeconds = CS.UnityEngine.WaitForSeconds
--WaitForEndOfFrame = CS.UnityEngine.WaitForEndOfFrame
require("Loader")
Loader:Require("require_ex")

--CS API
CUtil = require "CUtil"
--����
require "Log"
--CS API
CSAPI = require "CSAPI"
if CSAPI.IsDomestic() then
    Json = require "rapidjson"
elseif CSAPI.IsADV() then
    Json = require "dkjson"
else
    Json = require "dkjson"
end
--Lua����
IS_CLIENT = true
USE_SERVER_LOG = true
require "ComUtils"

Cfgs = {}
require("ConfigInclude")
-- ReadAllConfig()

--�¼�����
EventType = require "EventType"
--全局枚举
require "GEnum"


--�ַ�������
StringUtil = require "StringUtil"

PlayerPrefs = require "PlayerPrefs"
--��Դ����
ResUtil = require "ResUtil"


FuncUtil = require "FuncUtil"
--���������
LayerUtil = require "LayerUtil"
--�������
ComUtil = require "ComUtil"
--����
TeamUtil = require "TeamUtil"

--�ַ�������
StringConstant = require "StringConstant"
StringTips = require "StringTips"
    
--�������
NetMgr = require "NetMgr"

--�����¼�
ViewEvent = require "ViewEvent"

ViewCommonBase = require "ViewCommonBase";

--Buffer����
BufferUtil = require "BufferUtil"-- ս��

TimeUtil = require "TimeUtil"

UIUtil = require "UIUtil"

ZYUtil = require "ZYUtil" --注音

require "ViewModelMgr"
--全局配置
require "GlobalConfig"
--声音
require "SoundMgr"
--场景加载器
require "SceneLoader"

--天空盒
require "SkyBoxMgr"

--技能工具
require "SkillUtil"

--item工具
ItemUtil = require "ItemUtil"

--敏感字屏蔽工具
MsgParser = require "MsgParser"

--多语言
require "LanguageMgr"

UIInfiniteUtil = require "UIInfiniteUtil"

--宿舍
require "DormLauncher"

--数数工具
require "ThinkingAnalyticsMgr"

--new工具
SectionNewUtil = require "SectionNewUtil"

--设置
require "SettingMgr"

--埋点管理
require "BuryingPointMgr"

--无限不规则滚动
UIInfiniteUnlimited = require "UIInfiniteUnlimited"

--紫龙事件名
require "ShiryuEventName"

--箭头显示
ArrowUtil = require "ArrowUtil"
