import undetected_chromedriver as uc
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium_stealth import stealth
import time
import json

# The URL of the website you want to scrape and the local path of the chromedriver you've downloaded
url = "https://leetcode.com/studyplan/top-sql-50/"
path = r"C:\Users\Varun Pravesh\Downloads\chromedriver-win64\chromedriver.exe"
userName = "ABC"
passWord = "xyz"

service = Service(executable_path=path)
driver = webdriver.Chrome(service=service)  # We craete an instance of the webdriver 
#driver = webdriver.Firefox()

driver.get(url)

# Wait time to allow the webpage to fully load
WebDriverWait(driver, 5).until(
    EC.presence_of_element_located((By.ID,"navbar_sign_in_button"))
)

signInElement = driver.find_element(By.ID,"navbar_sign_in_button")
signInElement.click()

# After clicking the sign in button again we wait for the login screen to load
WebDriverWait(driver, 10).until(
    EC.presence_of_element_located((By.ID,"id_login"))
)

userNameElement = driver.find_element(By.ID,"id_login")
userNameElement.clear()
userNameElement.send_keys(userName)       # Enter your Username

passwordElement = driver.find_element(By.ID,"id_password")
passwordElement.clear()
passwordElement.send_keys(passWord)           # Enter your Password

'''
WebDriverWait(driver, 10).until(
    EC.presence_of_element_located((By.ID,"cf-chl-widget-rwdvl"))
)

cloudFareElement = driver.find_element(By.ID,"cf-chl-widget-rwdvl")
cloudFareElement.clear()
cloudFareElement.click()

WebDriverWait(driver, 2).until(
    EC.presence_of_element_located((By.ID,"signin_btn"))
)
signInButtonElement = driver.find_element(By.ID,"signin_btn")
signInButtonElement.clear()
signInButtonElement.click()
'''

# Wait time to fully load the home/orignal page
WebDriverWait(driver, 20).until(
    EC.presence_of_element_located((By.CSS_SELECTOR, ".w-full.overflow-hidden.rounded-lg.border-\\[1\\.5px\\].border-lc-fill-02.dark\\:border-dark-lc-fill-02"))
)

container = driver.find_elements(By.CSS_SELECTOR, ".w-full.overflow-hidden.rounded-lg.border-\\[1\\.5px\\].border-lc-fill-02.dark\\:border-dark-lc-fill-02")

#print(container)

answersDict = {}


for item in container:
    titleElements = item.find_elements(By.CSS_SELECTOR, ".text-\\[12px\\].font-medium")
    probElements = item.find_elements(By.CSS_SELECTOR,".text-body.max-w-\\[75\\%\\].font-medium.text-lc-text-primary.dark\\:text-dark-lc-text-primary") 
    #print(item.get_attribute("textContent"))
    
    for title in titleElements:
        #print("\n")
        section_title = title.get_attribute("textContent").strip()
        
        if section_title not in answersDict:
            answersDict[section_title] = {}
        
        
        
    for prob in probElements:
        #print("\n")
        problem_title = prob.get_attribute("textContent").strip()
        #We assign the current TAB to a variable so that when we've completed scraping the newly opened TAB we can switch back to the ORIGINAL TAB
        original_window = driver.current_window_handle
        
        # This is the link we're going to open (By default it opens in a new tab)
        #newSampleTab = driver.find_element(By.CSS_SELECTOR,".text-body.max-w-\\[75\\%\\].font-medium.text-lc-text-primary.dark\\:text-dark-lc-text-primary")
        
        assert len(driver.window_handles) == 1      # Make sure there is only tab at this time
        
        prob.click()
        
        WebDriverWait(driver, 2).until(
            EC.number_of_windows_to_be(2))
        
        for window_handle in driver.window_handles:
            if window_handle != original_window:            # Each TAB has a separate window handle so we this logic to switch to the new TAB
                driver.switch_to.window(window_handle)      
                break
            
        # Waiting for the Elements to load   
        WebDriverWait(driver, 5).until(
            EC.presence_of_element_located((By.ID, "submissions_tab"))          
        )
        
        submissionButton = driver.find_element(By.ID, "submissions_tab")            # Shows us all our previous submissions
        submissionButton.click()
        
        # Waiting for the Elements to load  
        WebDriverWait(driver, 5).until(
            EC.presence_of_element_located((By.CSS_SELECTOR, ".group.flex.w-full.flex-nowrap.items-center.outline-0.transition-colors.duration-300.focus\\:bg-transparent.text-label-3.dark\\:text-dark-label-3.hover\\:text-label-1.dark\\:hover\\:text-dark-label-1.rounded-lg"))
        ) 
        
        statusButton = driver.find_element(By.CSS_SELECTOR, ".group.flex.w-full.flex-nowrap.items-center.outline-0.transition-colors.duration-300.focus\\:bg-transparent.text-label-3.dark\\:text-dark-label-3.hover\\:text-label-1.dark\\:hover\\:text-dark-label-1.rounded-lg")
        statusButton.click()
        
        accepted_button = driver.find_element(By.XPATH, "//div[@class='truncate' and text()='Accepted']")
        accepted_button.click()                                                     # We want only the Accepted submissions so we filter them
        
        topSubmission = driver.find_element(By.CSS_SELECTOR, ".dark\\:text-dark-green-s")       
        topSubmission.click()                                                       # Selecting the top submission (most recent submission)
        
        # Waiting for the Elements to load  
        WebDriverWait(driver, 5).until(
            EC.presence_of_element_located((By.CSS_SELECTOR, ".relative.w-full.overflow-hidden.rounded-lg.bg-fill-quaternary"))
        )
        
        answer = driver.find_element(By.CSS_SELECTOR, ".relative.w-full.overflow-hidden.rounded-lg.bg-fill-quaternary")         # We the answer from here
        
        answerText = answer.get_attribute("textContent")
        
        words_to_remove = ["View", "More"]
        
        filtered_text = " ".join([word for word in answerText.split() if word not in words_to_remove])
        #print(filtered_text)
        
        answersDict[section_title][problem_title] = filtered_text
                
        
        driver.close()
        driver.switch_to.window(original_window)
        

print(answersDict)

with open("D:\Selenium\LeetCodeScrape\leetcodescrape.json","w") as f:
    json.dump(answersDict, f, indent=4)







