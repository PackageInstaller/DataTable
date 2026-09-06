local CSurveyConfig = BeanManager.GetTableByName("mail.csurveyconfig")
local CSurveyQuestionsTable = BeanManager.GetTableByName("mail.csurveyquestions")
local ItemTypeEnum = LuaNetManager.GetBeanDef("protocol.item.beans.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local SurveyMainDialog = class("SurveyMainDialog", Dialog)
SurveyMainDialog.AssetBundleName = "ui/layouts.survey"
SurveyMainDialog.AssetName = "SurveyMain"

local function split(str, reps)
  local resultStrList = {}
  string.gsub(str, "[^" .. reps .. "]+", function(w)
    table.insert(resultStrList, w)
  end)
  return resultStrList
end

function SurveyMainDialog:Ctor(...)
  SurveyMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._mail = nil
  self._itemsData = {}
  self._pagesData = {}
  self._currentPageIndex = 0
  self._currentPageQuestions = {}
  self._answerData = {}
  self._totleDelta = 0
end

function SurveyMainDialog:OnCreate()
  self._closeBtn = self:GetChild("CloseBtn")
  self._startPage = self:GetChild("Frame/SurveyStartPage")
  self._startPage_title = self:GetChild("Frame/SurveyStartPage/TitleBack/Title")
  self._startPage_headNote = self:GetChild("Frame/SurveyStartPage/HeadNote")
  self._startPage_count = self:GetChild("Frame/SurveyStartPage/Count")
  self._startPage_itemPanel = self:GetChild("Frame/SurveyStartPage/AwardFrame")
  self._startPage_startBtn = self:GetChild("Frame/SurveyStartPage/StartBtn")
  self._startPage_itemFrame = TableFrame.Create(self._startPage_itemPanel, self, false, false)
  self._surveyPage = self:GetChild("Frame/SurveyPage")
  self._surveyPage_title = self:GetChild("Frame/SurveyPage/TitleBack/Title")
  self._surveyPage_totalCount = self:GetChild("Frame/SurveyPage/TotalCount")
  self._surveyPage_finishCount = self:GetChild("Frame/SurveyPage/FinishCount")
  self._surveyPage_questionPanel = self:GetChild("Frame/SurveyPage/QuestionFrame")
  self._surveyPage_progressBar = self:GetChild("Frame/SurveyPage/Progress/ProgressBar")
  self._surveyPage_progressBarImage = self._surveyPage_progressBar:GetUIObject():GetComponent("Image")
  self._surveyPage_pageNextBtn = self:GetChild("Frame/SurveyPage/PageNext")
  self._surveyPage_pageNextBtnTxt = self:GetChild("Frame/SurveyPage/PageNext/_Text")
  self._surveyPage_pageNextSubmitBtn = self:GetChild("Frame/SurveyPage/SubmitBtn")
  self._surveyPage_pageBeforeBtn = self:GetChild("Frame/SurveyPage/PageBefore")
  self._surveyPage_questionFrame = TableFrame.Create(self._surveyPage_questionPanel, self, true, true, true)
  self._startPage_startBtn:Subscribe_PointerClickEvent(self.OnStartBtn, self)
  self._surveyPage_pageNextBtn:Subscribe_PointerClickEvent(self.OnNext, self)
  self._surveyPage_pageBeforeBtn:Subscribe_PointerClickEvent(self.OnBefore, self)
  self._surveyPage_pageNextSubmitBtn:Subscribe_PointerClickEvent(self.OnSubmit, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function SurveyMainDialog:OnDestroy()
  self._startPage_itemFrame:Destroy()
  self._surveyPage_questionFrame:Destroy()
end

function SurveyMainDialog:Init(mail)
  self._mail = mail
  self._surveyPage:SetActive(false)
  local recorder = CSurveyConfig:GetRecorder(mail.questId)
  self._startPage_title:SetText(recorder.name)
  self._startPage_headNote:SetText(recorder.headnote)
  self._pagesData = {}
  for i, value in ipairs(recorder.pages) do
    local temp = {}
    for v in string.gmatch(value, "%d*") do
      v = tonumber(v)
      table.insert(temp, v)
    end
    self._pagesData[i] = {}
    self._pagesData[i].questions = temp
  end
  for i, value in ipairs(recorder.pageRequires) do
    local temp = {}
    local requiresArray = split(value, ";")
    for j, requiresArrayValue in pairs(requiresArray) do
      local idAndAnswer = split(requiresArrayValue, "@")
      local questId = idAndAnswer[1]
      local answers = idAndAnswer[2]
      temp[j] = {}
      temp[j].questId = tonumber(questId)
      if answers then
        temp[j].answers = split(answers, ",")
        for k, answer in pairs(temp[j].answers) do
          answer = tonumber(answer)
        end
      end
    end
    self._pagesData[i].requires = temp
  end
  local count = self:GetTotleCount()
  self._startPage_count:SetText(count)
  self._itemsData = mail.attachmentList
  self._startPage_itemFrame:ReloadAllCell()
  self._startPage:SetActive(true)
end

function SurveyMainDialog:RefreshQuistionPanel(index, isNext)
  self._currentPageIndex = index
  if not self:IsPageCondition(self._pagesData[index].requires) then
    if isNext then
      self:RefreshQuistionPanel(index + 1, true)
    else
      self:RefreshQuistionPanel(index - 1, false)
    end
    return
  end
  if self._currentPageIndex == #self._pagesData then
    self._surveyPage_pageNextSubmitBtn:SetActive(true)
    self._surveyPage_pageNextBtn:SetActive(false)
    self._surveyPage_pageBeforeBtn:SetActive(false)
  else
    self._surveyPage_pageNextSubmitBtn:SetActive(false)
  end
  if self._currentPageIndex == 1 then
    self._surveyPage_pageBeforeBtn:SetInteractable(false)
  else
    self._surveyPage_pageBeforeBtn:SetInteractable(true)
  end
  local recorder = CSurveyConfig:GetRecorder(self._mail.questId)
  self._surveyPage_title:SetText(recorder.name)
  local totleCount = self:GetTotleCount()
  local finishiCount = table.nums(self._answerData)
  self._surveyPage_totalCount:SetText(totleCount)
  self._surveyPage_finishCount:SetText(finishiCount)
  self._surveyPage_progressBarImage.fillAmount = finishiCount / totleCount
  self._currentPageQuestions = {}
  for i, questId in pairs(self._pagesData[index].questions) do
    local temp = {}
    recorder = CSurveyQuestionsTable:GetRecorder(questId)
    temp.id = recorder.id
    temp.questionType = recorder.questionType
    temp.questionTitle = recorder.questionTitle
    temp.selection = recorder.selection
    temp.multiCountMin = recorder.multiCountMin
    temp.multiCountMax = recorder.multiCountMax
    temp.confirmAnswer = recorder.confirmAnswer
    table.insert(self._currentPageQuestions, temp)
  end
  self._surveyPage_questionFrame:ReloadAllCell()
  self._surveyPage_questionFrame:MoveToTop()
  self:SetNextBtnState()
end

function SurveyMainDialog:RefreshProgress()
  local totleCount = self:GetTotleCount()
  local finishiCount = table.nums(self._answerData)
  self._surveyPage_totalCount:SetText(totleCount)
  self._surveyPage_finishCount:SetText(finishiCount)
  self._surveyPage_progressBarImage.fillAmount = finishiCount / totleCount
end

function SurveyMainDialog:GetTotleCount()
  local count = 0
  for i, value in ipairs(self._pagesData) do
    if tonumber(value.requires[1].questId) == 0 then
      count = count + #value.questions
    elseif self:IsPageCondition(value.requires) then
      count = count + #value.questions
    end
  end
  return count
end

function SurveyMainDialog:IsPageCondition(requires)
  if tonumber(requires[1].questId) == 0 then
    return true
  end
  local condition = false
  for j, requireValue in ipairs(requires) do
    local answerData = self._answerData[requireValue.questId]
    if answerData then
      if #answerData == #requireValue.answers then
        for key, answerValue in pairs(answerData) do
          if answerValue ~= tonumber(requireValue.answers[key]) then
            condition = false
            return condition
          else
            condition = true
          end
        end
      end
    else
      return false
    end
  end
  return condition
end

function SurveyMainDialog:OnBackBtnClicked()
  self:Destroy()
end

function SurveyMainDialog:OnStartBtn()
  self._surveyPage:SetActive(true)
  self._startPage:SetActive(false)
  self:RefreshQuistionPanel(1)
end

function SurveyMainDialog:OnNext()
  self:RefreshQuistionPanel(self._currentPageIndex + 1, true)
end

function SurveyMainDialog:OnSubmit()
  local ccommitquest = LuaNetManager.CreateProtocol("protocol.mail.ccommitquest")
  if ccommitquest then
    local answer = ""
    for key, answers in pairs(self._answerData) do
      answer = answer .. key .. "@"
      for i, value in ipairs(answers) do
        answer = answer .. value .. ","
      end
      answer = string.sub(answer, 1, -2)
      answer = answer .. ";"
    end
    ccommitquest.uniqueId = self._mail.uniqueId
    ccommitquest.answer = answer
    local validate = 0
    for i, pageValue in pairs(self._pagesData) do
      for j, questionId in pairs(pageValue.questions) do
        local recorder = CSurveyQuestionsTable:GetRecorder(questionId)
        if recorder.questionType == 4 and self._answerData[recorder.id][1] and self._answerData[recorder.id][1] == recorder.confirmAnswer then
          validate = 1
        end
      end
    end
    ccommitquest.validate = validate
    ccommitquest:Send()
    self:Destroy()
  end
end

function SurveyMainDialog:OnBefore()
  if self._currentPageIndex > 1 then
    self:RefreshQuistionPanel(self._currentPageIndex - 1, false)
  end
end

function SurveyMainDialog:SetNextBtnState()
  for key, value in pairs(self._currentPageQuestions) do
    if self._answerData[value.id] then
      if value.questionType == 2 then
        if #self._answerData[value.id] < value.multiCountMin then
          self._surveyPage_pageNextBtn:SetInteractable(false)
          self._surveyPage_pageNextSubmitBtn:SetInteractable(false)
          return
        end
      elseif #self._answerData[value.id] < 1 then
        self._surveyPage_pageNextBtn:SetInteractable(false)
        self._surveyPage_pageNextSubmitBtn:SetInteractable(false)
        return
      end
    else
      self._surveyPage_pageNextBtn:SetInteractable(false)
      self._surveyPage_pageNextSubmitBtn:SetInteractable(false)
      return
    end
  end
  if self._currentPageIndex == #self._pagesData then
    self._surveyPage_pageNextBtn:SetInteractable(false)
  else
    self._surveyPage_pageNextBtn:SetInteractable(true)
  end
  self._surveyPage_pageNextSubmitBtn:SetInteractable(true)
end

function SurveyMainDialog:OnSingleOptionChecked(questionId, answer, isChecked)
  if isChecked then
    self._answerData[questionId] = {answer}
  elseif self._answerData[questionId] and self._answerData[questionId][1] == answer then
    self._answerData[questionId] = nil
  end
end

function SurveyMainDialog:OnMultipleOptionChecked(questionId, answers)
  if 0 < #answers then
    self._answerData[questionId] = answers
  else
    self._answerData[questionId] = nil
  end
end

function SurveyMainDialog:OnTxtInput(questionId, str)
  if str then
    self._answerData[questionId] = {str}
  else
    self._answerData[questionId] = nil
  end
end

function SurveyMainDialog:IsOptionChecked(id, index)
  if self._answerData[id] then
    for key, value in pairs(self._answerData[id]) do
      if index == value then
        return true
      end
    end
  end
  return false
end

function SurveyMainDialog:NumberOfCell(frame)
  if frame == self._startPage_itemFrame then
    return #self._itemsData
  end
  if frame == self._surveyPage_questionFrame then
    return #self._currentPageQuestions
  end
end

function SurveyMainDialog:CellAtIndex(frame, index)
  if frame == self._startPage_itemFrame then
    return "survey.surveyitemcell"
  end
  if frame == self._surveyPage_questionFrame then
    if self._currentPageQuestions[index].questionType == 3 then
      return "survey.describequestioncell"
    else
      return "survey.selectquestioncell"
    end
  end
end

function SurveyMainDialog:DataAtIndex(frame, index)
  local data = {}
  if frame == self._startPage_itemFrame then
    local info = self._itemsData[index]
    local item
    if info.itemtype == ItemTypeEnum.BASEITEM then
      item = Item.Create(info.id)
    elseif info.itemtype == ItemTypeEnum.EQUIP then
      item = Equip.Create(info.id)
    elseif info.itemtype == ItemTypeEnum.SKILL then
      item = Skill.Create(info.id)
    end
    item:InitWithFull(info)
    data.item = item
  end
  if frame == self._surveyPage_questionFrame then
    data = self._currentPageQuestions[index]
  end
  return data
end

function SurveyMainDialog:ShouldLengthChange()
  return true
end

return SurveyMainDialog
