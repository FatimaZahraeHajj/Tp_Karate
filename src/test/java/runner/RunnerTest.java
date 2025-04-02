package runner;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.Test;

import static org.junit.Assert.assertTrue;

public class RunnerTest {

    @Test
    public void testParallel() {
        Results results = Runner.path("classpath:features")
                .parallel(1);
        assertTrue("Il y a des échecs : " + results.getErrorMessages(), results.getFailCount() == 0);
    }
}
