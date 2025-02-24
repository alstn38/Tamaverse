# 🐣 Tamaverse - 내 손안의 친구, 다마고치

- **Tamaverse**는 Tamagotchi + Universe의 합성어로 다양한 다마고치를 키우는 게임입니다.
- 먹이와 물을 주고 다마고치를 키워보세요 !🧑‍🍼

<br>

# 주요 기능

### **🌤️ 다마고치 선택 화면**

|   다마고치 선택   | 
|  :-------------: |
| <img width=200 src="https://github.com/user-attachments/assets/24f5cbde-2b32-4cf1-9acc-1a86766336f7"> | 

- 키우고 싶은 다마고치를 선택할 수 있습니다.

<br>

### 🕹️ 게임 화면

|   게임 화면   | 
|  :-------------: |
| <img width=200 src="https://github.com/user-attachments/assets/06719980-2fbb-4f2e-8c2c-56314708a7cb"> | 

- 다마고치에게 **먹이**와 **물**을 줄 수 있습니다.
- 한 번에 식사 가능한 먹이의 수는 제한되어있습니다.
- 다마고치에게 **먹이와 물을 준다면 레벨이 상승**합니다.
- 레벨에 따라 다마고치의 이미지가 변화합니다.
- 다마고치는 **사용자의 이름과 함께** 사용자에게 말을 겁니다.

<br>

### ⚙ 설정 화면

|   닉네임 수정   |   다마고치 변경   |  데이터 초기화   |
|  :-------------: |  :-------------: |  :-------------: |
| <img width=200 src="https://github.com/user-attachments/assets/12fde5dc-0c79-4366-a8b6-c985e7a51232"> |  <img width=200 src="https://github.com/user-attachments/assets/01e9cc27-de0d-4837-8dfd-afa244de0b8a"> |  <img width=200 src="https://github.com/user-attachments/assets/06120823-92ed-4015-95ea-4611b848392c"> |

- 사용자의 이름을 변경할 수 있습니다.
- 다마고치를 변경할 수 있습니다. 기존 데이터는 유지됩니다.
- 데이터를 초기화할 수 있습니다. 초기화 시 캐릭터 선택화면으로 이동합니다.

<br>

# 🎯 앱 기술 설명

### 사용자 UX 경험 향상을 위한 고민

- 입력가능한 먹이의 수 범위가 아닐 경우 Alert를 통해 사용자에게 피드백을 전달했습니다.
- 먹이 입력의 TextField와 버튼의 Layout을 키보드에 대응하여 키보드 가림 현상을 해결했습니다.

# 🛠 앱 기술 스택

- ****Architecture***: MVVM
- ****UI Framework***: UIKit
- ****Data Persistence***: UserDefaults
- ****External dependency***: RxSwift, SnapKit

<br>

# 🎯 개발 환경

![iOS](https://img.shields.io/badge/iOS-16%2B-000000?style=for-the-badge&logo=apple&logoColor=white)

![Swift](https://img.shields.io/badge/Swift-5.9-FA7343?style=for-the-badge&logo=swift&logoColor=white)

![Xcode](https://img.shields.io/badge/Xcode-16.2-1575F9?style=for-the-badge&logo=Xcode&logoColor=white)

<br>

# 📅 개발 정보

- ****개발 기간***: 2025.02.20 ~ 2025.02.23
- ****개발인원***: 1명
