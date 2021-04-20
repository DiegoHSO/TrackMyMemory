/*:
 # Dynamic Partitioning
 
 Dynamic Partitioning is the technique that came as evolution of [**Fixed Partitioning**](@previous). It is also used to put more than one **[process](glossary://process)** in the **[main memory](glossary://mainmemory)**, but in a different and more efficient way.

 ## How does Dynamic Partitioning work?
 
 In Dynamic Partitioning, main memory is divided into partitions of variable length and number, depending on user's demand. When a process is brought into main memory, the algorithm allocates the exacly amount of memory that the process needs to run and nothing more.
 
 Inside this technique, there are three algorithms that decide how and where to assign processes into main memory. Let's learn a bit about them:
 
 1. **First Fit**: Begins to scan memory from the beginning and chooses the first avaliable block that is large enough in order to store the process.
 
 2. **Best Fit**: Chooses the memory block that is closest in size to the process that requested the space.
 
 3. **Next Fit**: Begins to scan memory from the location where the last process was stored, then chooses the next avaliable memory block that fits the process.
 
 - Note: First Fit is the simplest algorithm and usually is the best and fastest option between Best Fit and Next Fit.

 
## Strengths ✅:
 There isn't **[Internal Fragmentation](glossary://internalfragmentation)**, since memory is allocated by demand. Due to that, the technique demands little operating system overhead.
 
## Weaknesses ❌:
 In cases where there is a free memory block between two processes that are being executed (*pause for breath*) and another free memory block after these processes, there is a situation called **[External Fragmentation](glossary://externalfragmentation)**. This is not a good situation, because, for example, if we have a process which size is equal than the both free memory blocks said before, we cannot execute it, since these two blocks behave separately.
 
 
 # Let's play!
 
 In this game on the right, you are introduced to a four gigabyte sized main memory in a single block and six applications. The placement algorithm that was chose within Dynamic Partitioning is First Fit.
 
 - Callout(How to play):
 Click the "Run" button under an app and see how the technique responds to your request! Also, try to run multiple apps simultaneously to see how dynamic partitioning is made 🤗
 
 Let's go! ⚙️
 
 - Note: Click on "Run My Code" when you're ready to start the game.

 */

//#-hidden-code
import PlaygroundSupport

PlaygroundPage.current.setLiveView(DynamicPartitioningView())
//#-end-hidden-code

